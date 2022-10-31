/**
 * @brief library of c++ functions/classes. written and used by Ohio University Software Development Club
 * 
 */

namespace sdc {

    /**
     * @brief 
     * 
     * @param n 
     * @return int 
     */
    int fib(int n) {
        if (n == 0) {
            return 0;
        } else if (n == 1) {
            return 1;
        } else {
            return fib(n-1) + fib(n-2);
        }
    }
}