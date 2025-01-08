% Solving problem 3 applying Lagrange Multipliers

% The constraint sum(x_j) <= Q - R, now becomes an equality constraint:
% sum(x_j) = Q - R -> g(x_j) = sum(x_j) -(Q - R) = 0

% The Lagrangian is L = TNB(x_j) - lambda * g(x_j)

% We want to solve grad L = 0, to do so, 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We define symbolically the functions in order to apply differentation

% Symbolic variables

syms x1 x2 x3 lambda QR

% Maximum Production Function (p = P)

P1 = 0.4 * x1^0.9;
P2 = 0.5 * x2^0.8;
P3 = 0.6 * x3^0.7;

% Production Cost Function

C1 = 3 * P1^1.3;
C2 = 5 * P2^1.2;
C3 = 6 * P3^1.15;

% Product Price Function

c1 = 12 - P1;
c2 = 20 - 1.5 * P2;
c3 = 28 - 2.5 * P3;

% Total Net Benefit (TNB) Function

TNB = c1 * P1 + c2 * P2 + c3 * P3 - (C1 + C2 + C3);

% Equallity Constraint

g = x1 + x2 + x3 - QR;

% Lagrangian

L = TNB - lambda * g;

% We apply the gradient

dL_dx1 = diff(L, x1);
dL_dx2 = diff(L, x2);
dL_dx3 = diff(L, x3);
dL_dlambda = diff(L, lambda);

% We convert them to MATLAB (numerical) functions

QR_val = 50; % Maximum of water available for allocation

f1 = matlabFunction(dL_dx1, 'Vars', [x1, x2, x3, lambda]);
f2 = matlabFunction(dL_dx2, 'Vars', [x1, x2, x3, lambda]);
f3 = matlabFunction(dL_dx3, 'Vars', [x1, x2, x3, lambda]);
f4 = matlabFunction(dL_dlambda, 'Vars', [x1, x2, x3, lambda, QR]);

TNB_numeric = matlabFunction(TNB, 'Vars', [x1,x2,x3]); % Also convert TNB to numeric to evaluate it later

% We define a system of equations for applying fsolve
% We define x = (x_1,x_2,x_3,lambda)

F = @(x) [
    f1(x(1), x(2), x(3), x(4)); 
    f2(x(1), x(2), x(3), x(4)); 
    f3(x(1), x(2), x(3), x(4)); 
    f4(x(1), x(2), x(3), x(4), QR_val)];

x0 = [QR_val/3,QR_val/3,QR_val/3,1]; % Initial guess


% Finally apply fsolve (with the necessary options

options = optimoptions('fsolve', 'Display', 'iter');

[x_sol, fval, exitflag] = fsolve(F, x0, options);

fprintf('Optimal Water Allocations: x1 = %.2f, x2 = %.2f, x3 = %.2f\n', x_sol(1), x_sol(2), x_sol(3));
fprintf('Total Net Benefit: %.2f\n', TNB_numeric(x_sol(1), x_sol(2), x_sol(3)));
