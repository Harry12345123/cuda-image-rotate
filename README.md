# CUDA Image Rotate

A CUDA C++ project for rotating images on the GPU.

This repository is designed to help developers learn image geometry transformation with CUDA.

## Features

- image rotation with CUDA
- geometric transformation on GPU
- beginner-friendly CUDA example
- practical visual computing demo

## Tech Stack

- C++
- CUDA
- OpenCV

## Project Goal

This project teaches:

- how rotation mapping works in image processing
- how CUDA threads handle transformed coordinates
- how GPU parallelism supports visual transformation tasks

## Future Improvements

- arbitrary angle support
- interpolation optimization
- video rotation pipeline
- Jetson deployment

## Related Topics

CUDA, Image Rotation, GPU Computing, Visual Computing, C++, OpenCV

## Author

Harry12345123

## Requirements

Before building this project, make sure your system has:

- CUDA Toolkit
- OpenCV
- CMake 3.18 or later
- C++17 compatible compiler

## Build
Use the following commands to compile the project:

```bash
mkdir build
cd build
cmake ..
make -j

Run
After building, run the program with:

./cuda_image_rotate input.jpg

Notes
Replace input.jpg with your own test image.
Make sure OpenCV and CUDA are installed correctly.
