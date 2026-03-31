#include <cuda_runtime.h>
#include <math.h>

__global__ void rotate_kernel(const unsigned char *in, unsigned char *out, int w, int h, int c, float rad)
{
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= w || y >= h)
        return;
    float cx = w * 0.5f;
    float cy = h * 0.5f;
    float tx = x - cx;
    float ty = y - cy;
    float src_x = cosf(rad) * tx + sinf(rad) * ty + cx;
    float src_y = -sinf(rad) * tx + cosf(rad) * ty + cy;
    if (src_x >= 0 && src_x < w && src_y >= 0 && src_y < h)
    {
        int ix = (int)src_x;
        int iy = (int)src_y;
        for (int ch = 0; ch < c; ++ch)
        {
            out[(y * w + x) * c + ch] = in[(iy * w + ix) * c + ch];
        }
    }
}
void rotate_cuda(const unsigned char *in, unsigned char *out, int width, int height, int channels, float angle_deg)
{
    size_t bytes = width * height * channels;
    unsigned char *d_in = nullptr, *d_out = nullptr;
    cudaMalloc(&d_in, bytes);
    cudaMalloc(&d_out, bytes);
    cudaMemcpy(d_in, in, bytes, cudaMemcpyHostToDevice);
    cudaMemset(d_out, 0, bytes);
    float rad = angle_deg * 3.1415926f / 180.0f;
    dim3 block(16, 16);
    dim3 grid((width + 15) / 16, (height + 15) / 16);
    rotate_kernel<<<grid, block>>>(d_in, d_out, width, height, channels, rad);
    cudaDeviceSynchronize();
    cudaMemcpy(out, d_out, bytes, cudaMemcpyDeviceToHost);
    cudaFree(d_in);
    cudaFree(d_out);
}