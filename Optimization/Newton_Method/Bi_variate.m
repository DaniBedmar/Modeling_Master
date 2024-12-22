disp("Bi-variate minimum finding using Newton's method in the Rosenbrock function");
f = @(x, y) 100 * (x.^2 - y).^2 + (1 - x).^2;
x0 = 934;
y0 = -835;

disp("If the initial point is ("+x0+", "+0.5+")");
[sol, gradient_norms, NTiter, tries] = Bi_variate_Newton(x0, y0, 100, 1e-6, 1e-6, 1e-6);
disp(" ");

disp("In " + NTiter + " Iterations we reach the miniumum: "+ sol);
disp("In the coordinates "+tries(NTiter,1)+", "+tries(NTiter,2))

disp("Here are the approximations made:");
disp(tries);

x_range = -10:0.1:10;
y_range = -10:0.1:10;
Bi_variate_Plot(f, x_range, y_range, tries, NTiter,gradient_norms);