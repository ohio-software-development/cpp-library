
#include "Matrix.h"

using namespace std;

Matrix::Matrix(size_t r, size_t c) {

    rows = r;
    columns = c;

    int error_check = cudaMallocManaged(&data, sizeof(float)*rows*columns);
    if (error_check != 0) {

        cout << "error: " << error_check << endl;

    }

    for (size_t i = 0; i < rows*columns; i++) {

        data[i] = 0.0; 

    }

}

Matrix::~Matrix() {

    cudaFree(data);

}

size_t Matrix::rowSize() const {

    return rows;

}

size_t Matrix::columnSize() const {

    return columns; 

}

float* Matrix::operator[](size_t index) {

    return &data[index];

}

void Matrix::print() {

    for (size_t r  = 0; r < rows; r++) {

        for (size_t c = 0; c < columns; c++) {

            cout << data[r*rows + c] << " ";

        }

        cout << endl;
    }

}

void Matrix::scalarMultiplication(float scalar) {

    scalarMultiplicationHelper<<<1, 128>>>(scalar, *this);
    int error_check = cudaDeviceSynchronize();
    if (error_check != 0) {

        cout << "error: " << error_check << endl;

    }

}

__global__ void scalarMultiplicationHelper(float &scalar, Matrix &m) {

    for (size_t r = threadIdx.x; r < m.rows; r += blockDim.x) {

        for (size_t c = 0; c < m.columns; c++) {

            m.data[r*m.rows + c] *= scalar;

        }

    }

}




