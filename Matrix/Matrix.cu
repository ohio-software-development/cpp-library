
#include "Matrix.h"

using namespace std;

const size_t THRED_SIZE = 512;

Matrix::Matrix(size_t r, size_t c) {

    rows = r;
    columns = c;

    int error_check = cudaMallocManaged(&data, sizeof(double)*rows*columns);
    if (error_check != 0) {

        cout << "error: " << error_check << endl;

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

double* Matrix::operator[](size_t index) {

    return &data[index*columns];

}

void Matrix::print() {

    for (size_t r  = 0; r < rows; r++) {

        for (size_t c = 0; c < columns; c++) {

            cout << data[r*columns + c] << " ";

        }

        cout << endl;
    }

}

void Matrix::scalarMultiplication(double scalar) {

    scalarMultiplicationHelper<<<1, THRED_SIZE>>>(scalar, *this);
    int error_check = cudaDeviceSynchronize();
    if (error_check != 0) {

        cout << "error: " << error_check << endl;

    }

}

void Matrix::scalarAddition(double scalar) {

    scalarAdditionHelper<<<1, THRED_SIZE>>>(scalar, *this);
    int error_check = cudaDeviceSynchronize();
    if (error_check != 0) {

        cout << "error: " << error_check << endl;

    }

}

void Matrix::matrixMultiply(Matrix &other) {

    Matrix* temp = new Matrix(rows, other.columns);
    multiplyMatrixHelper<<<1, 1>>>(*this, other, temp);
    cudaDeviceSynchronize();

}

__global__ void scalarMultiplicationHelper(double &scalar, Matrix &m) {

    for (size_t i = threadIdx.x; i < m.rows*m.columns; i += blockDim.x) {

        m.data[i] *= scalar;

    }

}

__global__ void scalarAdditionHelper(double &scalar, Matrix &m) {

    for (size_t i = threadIdx.x; i < m.rows*m.columns; i += blockDim.x) {

        m.data[i] += scalar;

    }

}

__global__ void setAll(double setTo, Matrix &setting) {

    for (size_t i = threadIdx.x; i < setting.columns * setting.rows; i += blockDim.x) {

        setting.data[i] = setTo; 

    }

}

__global__ void makeIdentity(Matrix &setting) {

    for (size_t i = threadIdx.x; i < setting.rows * setting.columns; i += blockDim.x) {

        if ((i /setting.rows) == (i % setting.columns)) {

            setting.data[i] = 1.0; 

        } else {

            setting.data[i] = 0.0; 

        }

    }

}

__global__ void multiplyMatrixHelper(Matrix &m1, Matrix &m2, Matrix* temp) {

    for (size_t r1 = 0; r1 < m1.rows; r1++) {

        for (size_t c2 = 0; c2 < m1.columns; c2++) {

            for (size_t r2 = 0; r2 < m2.rows; r2++) {

                temp->data[r1*m1.columns + c2] = m1.data[r1*m1.columns + r2] + m2.data[r2*m2.columns + c2];

            }            

        }

    } 

    m1.data = temp->data;
    m1.rows = temp->rows;
    m1.columns = temp->columns;

}

Matrix& identityMatrix(size_t r) {

    Matrix* m = new Matrix(r, r);
    makeIdentity<<<1, THRED_SIZE>>>(*m);
    cudaDeviceSynchronize();
    return *m;

}

Matrix& zeroMatrix(size_t r, size_t c) {

    Matrix* m = new Matrix(r, c);
    setAll<<<1, THRED_SIZE>>>(0.0, *m);
    cudaDeviceSynchronize();
    return *m;

}

Matrix& oneMatrix(size_t r, size_t c) {

    Matrix* m = new Matrix(r, c);
    setAll<<<1, THRED_SIZE>>>(1.0, *m);
    cudaDeviceSynchronize();
    return *m;

}

