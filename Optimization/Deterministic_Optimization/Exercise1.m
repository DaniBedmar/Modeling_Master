% f(x,y) = 200x + 600y
% x + y <= 80
% x - y <= 30
% x <= 160
% x <= 0, y <= 0

% linprog
f = [-200; -600];

A = [1, 1; 
    1, -1; 
    1, 0]; 
b = [80;
    30;
    160];
lb = [0; 0];
ub = [];

% Interior-point
options1 = optimoptions('linprog', 'Algorithm', 'interior-point');
tic;
[x1, fval1] = linprog(f, A, b, [], [], lb, ub, options1);
time_interior = toc;
disp(['Interior-point time: ', num2str(time_interior), ' seconds']);
fprintf('Optimal number of ceramic items (x): %.2f\n', x(1));
fprintf('Optimal number of metal items (y): %.2f\n', x(2));
fprintf('Maximum profit: %.2f euros\n', -fval);

% Dual-simplex
options2 = optimoptions('linprog', 'Algorithm', 'dual-simplex');
tic;
[x2, fval2] = linprog(f, A, b, [], [], lb, ub, options2);
time_dual_simplex = toc;
disp(['Dual-simplex time: ', num2str(time_dual_simplex), ' seconds']);
fprintf('Optimal number of ceramic items (x): %.2f\n', x(1));
fprintf('Optimal number of metal items (y): %.2f\n', x(2));
fprintf('Maximum profit: %.2f euros\n', -fval);

% CVX
cvx_begin
    variables x y;
    maximize(200 * x + 600 * y)
    subject to
        x >= 0; 
        y >= 0;
        x + y <= 80;
        x <= 160;
        x <= y + 30;
cvx_end

fprintf('Solution obtained using the CVX toolbox \n')
fprintf('Optimal number of ceramic items (x): %.2f\n', x);
fprintf('Optimal number of copper items (y): %.2f\n', y);
fprintf('Maximum profit: %.2f euros\n', cvx_optval);