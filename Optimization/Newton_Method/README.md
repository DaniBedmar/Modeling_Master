In this assigment I had to discuss the advantages and disadvantages of using Newton's method for solving or finding minimums of functions. In order to do this discussion, I had to implement the Newton method for the uni variate and bi variate cases in MATLAB.

The implementation for the uni variate case is the MATLAB script file [Uni_variate.m](https://github.com/DaniBedmar/Modeling_Master/blob/main/Optimization/Newton_Method/Uni_Variate.m) and the implementation for the bi variate case is the MATLAB script file [Bi_variate.m](https://github.com/DaniBedmar/Modeling_Master/blob/main/Optimization/Newton_Method/Bi_variate.m)

The Newton method is an iterative approach used to find the minimums or the roots of a given function `f(x)`. Starting from an initial guess, the subsequent values of `x` are calculated using the formula:

$$
x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)},
$$

where `f'(x)` represents the derivative of `f` evaluated at the point `x`.

This process is repeated until consecutive values fall within a predefined neighborhood, determined by an error threshold, or when the derivative of the function at the point is sufficiently close to zero. To prevent indefinite iterations, a maximum number of iterations is typically specified.

Therefore, the implementation requires the following inputs: an initial guess, the maximum number of iterations, and tolerances for the error thresholds. The algorithm proceeds as follows:

- Initially, the iteration counter and a matrix to store the subsequent guesses and their values are initialized. The matrix is pre-initialized with a size equal to `MAXit × 2` to avoid memory reallocation during runtime.
- Next, a loop iteratively updates the value of `x`, appends the value of `x` and its new corresponding value to the matrix, and checks if any of the stopping criteria are met.
- Once the loop is finished, the matrix is truncated to match the number of iterations performed, freeing unused memory.
- Finally, two plots are generated: one showing the function and the different approximations made, and another showing the convergence of the method by plotting the distance of consecutive points.

The extension to `n` dimensions is relatively straightforward. In essence, the `n`-dimensional equivalent of the equation involves utilizing the gradient and the inverse of the Hessian matrix so that the subsequent values of `x` are calculated using the formula:

$$
\begin{bmatrix}
    x_{k+1} \\
    y_{k+1} \\
\end{bmatrix}
= \begin{bmatrix}
    x_{k} \\
    y_{k} \\
\end{bmatrix} - H^{-1} \nabla f(x_{k}, y_{k})
$$

Errors are calculated by taking the norm of the difference vector or the gradient. Finally, the matrices are resized to release unused memory, and the error evolution is visualized.

A brief report where I do my discussion on Newton's method can be find in [Newton_method.pdf](https://github.com/DaniBedmar/Modeling_Master/blob/main/Optimization/Newton_Method/Newton_method.pdf). 
