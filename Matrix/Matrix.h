

#define MATRIX_H
#ifdef MATRIX_H

#include <iostream>
#include <math.h>

/**
 * @brief Simple Matrix Class
 */
class Matrix { 

public:
    double* data;
    size_t rows;
    size_t columns;

public:
    /**
     * @brief Construct a new Matrix object
     * 
     * @param r 
     * @param c 
     */
    Matrix(size_t r = 1, size_t c = 1);

    /**
     * @brief Destroy the Matrix object
     */
    ~Matrix();

    /**
     * @brief Get the number of rows
     * 
     * @return size_t 
     */
    size_t rowSize() const;

    /**
     * @brief Get the number of columns
     * 
     * @return size_t 
     */
    size_t columnSize() const;

    /**
     * @brief print matrix
     */
    void print();

    /**
     * @brief access pointer to first element of row
     * 
     * @param index 
     * @return double* 
     */
    double* operator[](size_t index);

    /**
     * @brief Multiply Matrix by scalar
     * 
     * @param scalar 
     */
    void scalarMultiplication(double scalar); 

    /**
     * @brief Add a scalar to matrix 
     * 
     * @param scalar 
     */
    void scalarAddition(double scalar);

    void matrixMultiply(Matrix &other);

};

// Global Helper functions
/**
 * @brief External helper function for matrix class
 * 
 * @param scalar 
 * @param m 
 */
__global__ void scalarMultiplicationHelper(double &scalar, Matrix &m); 

/**
 * @brief Add a scalar to Matrix helper function
 * 
 * @param scalar 
 * @param m 
 * @return __global__ 
 */
__global__ void scalarAdditionHelper(double &scalar, Matrix &m);

/**
 * @brief Set all elements in matrix 
 * 
 * @param setTo 
 * @param setting 
 * @return __global__ 
 */
__global__ void setAll(double setTo, Matrix &setting);

/**
 * @brief Make matrix identity matrix 
 * 
 * @param setting 
 * @return __global__ 
 */
__global__ void makeIdentity(Matrix &setting);

__global__ void multiplyMatrixHelper(Matrix&, Matrix&, Matrix*);

// Other Functions
/**
 * @brief Create identity matrix
 * 
 * @param r 
 * @return Matrix& 
 */
Matrix &identityMatrix(size_t r = 1);

/**
 * @brief Create zero Matrix
 * 
 * @param r 
 * @param c 
 * @return Matrix& 
 */
Matrix& zeroMatrix(size_t r = 1, size_t c = 0);

/**
 * @brief Create Matrix full of 1 
 * 
 * @param r 
 * @param c 
 * @return Matrix& 
 */
Matrix& oneMatrix(size_t r = 1, size_t c = 0);


#endif 



