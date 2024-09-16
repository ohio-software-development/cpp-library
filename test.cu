#include <iostream>
#include <math.h>

#include "Matrix/Matrix.h"

using namespace std;

int main() {

    Matrix mat1 = oneMatrix(2, 2);
    mat1.print();
    Matrix mat2 = oneMatrix(2, 2);
    mat2.print();
    mat1.matrixMultiply(mat2);
    mat1.print();

    exit(0);
}

