

#define MATRIX_H
#ifdef MATRIX_H

#include <iostream>
#include <math.h>

class Matrix {

public:
    float* data;
    size_t rows;
    size_t columns;

public:
    Matrix(size_t r=1, size_t c=4);
    ~Matrix();
    void print();
    void scalarMultiplication(float scalar); 
    size_t rowSize() const;
    size_t columnSize() const;
    float* operator[](size_t index);

};

__global__ void scalarMultiplicationHelper(float &scalar, Matrix &m); 



#endif 



