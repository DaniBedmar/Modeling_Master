function [sol, gradient_norms, NTiter, tries] = Bi_variate_Newton(x0, y0, MAXit, tol1, tol2, tol3)
    % This function computes the minimum of the Rosenbrock function
    % f(x, y) = 100(x^2 - y)^2 + (1 - x)^2 using Newton's method.

    %Initilialization
    xk = x0;
    yk = y0;
    NTiter = 0;
    tries = zeros(MAXit, 2); 
    gradient_norms = zeros(1, MAXit);
    epsilon = 1e-6;

    % Newton's method loop
    for k = 1:MAXit
        NTiter = NTiter + 1;
        tries(k, :) = [xk, yk];

        dx = 400 * xk * (xk^2 - yk) + 2 * (xk - 1);
        dy = -200 * (xk^2 - yk);
        d_2x = 1200 * xk^2 - 400 * yk + 2;
        d_2y = 200;
        dxdy = -400 * xk;

        Hes = [d_2x, dxdy; dxdy, d_2y];
        grad = [dx; dy];
        
        if det(Hes) < 1e-12
            Hes = Hes + epsilon * eye(size(Hes));
        end

        %Compute the next points
        step = Hes \ grad;
        xk_next = xk - step(1);
        yk_next = yk - step(2);

        gradient_norms(k) = norm(grad);

        % Check for convergence
        if (abs(xk_next - xk) < tol1 && abs(yk_next - yk) < tol2) || ...
                abs(100 * (xk^2 - yk)^2 + (1 - xk)^2) < tol3
            break;
        end

        % Update
        xk = xk_next;
        yk = yk_next;
    end

    % Final results
    tries = tries(1:NTiter, :);
    gradient_norms = gradient_norms(1:NTiter);
    sol = 100 * (xk^2 - yk)^2 + (1 - xk)^2;
end
