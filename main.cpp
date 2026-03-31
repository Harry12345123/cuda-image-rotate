#include <opencv2/opencv.hpp>
#include <iostream>
void rotate_cuda(const unsigned char *in, unsigned char *out, int width, int height, int channels, float angle_deg);

int main(int argc, char **argv)
{
    std::string input = argc > 1 ? argv[1] : "input.jpg";
    cv::Mat img = cv::imread(input, cv::IMREAD_COLOR);
    if (img.empty())
        return -1;
    cv::Mat out(img.rows, img.cols, img.type(), cv::Scalar::all(0));
    rotate_cuda(img.data, out.data, img.cols, img.rows, img.channels(), 30.0f);
    cv::imwrite("output_rotate.jpg", out);
    return 0;
}