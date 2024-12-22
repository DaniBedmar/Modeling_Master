disp(sprintf("Uni-variate root finding using Newton's method \nin the function f(x)= 2x^3 - 3x^2 + 3"))
disp(" ")
x0 = -0.5;
disp("If the initial point is x= "+x0);
[sol,h,F_sol,NTiter, tries] = Uni_variate_Newton(x0,100,0.00001,0.00001);
disp(" ");
disp("In " + NTiter + " Iterations we reach the miniumum: "+ sol);
disp("In x = "+tries(NTiter,1))
disp(" ");
disp("Here are the approximations made:");
disp(tries);
Uni_variate_Plot(NTiter, tries);