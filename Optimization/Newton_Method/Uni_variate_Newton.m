function [sol,h,F_sol,NTiter, tries] = Uni_variate_Newton(x0,MAXit,tol1,tol2)
%This function will give us the root of the function f(x)= 2x^3 - 3x^2 + 3
%that has a solution at x ≈ -0.80644 and a local minium at x = 1 (f(1)=2)


%Initialize the necessary elements
NTiter = 0;
tries = zeros(MAXit, 2);
xk = x0;
%Newton method application
for k=1:1:MAXit
    NTiter = NTiter +1;
    disp("Working with x = " + string(xk));

    %We compute the next x
    sol = 2*xk^(3)-3*xk^(2)+3;
    F_sol = 6*xk^(2)-6*xk;
    if F_sol == 0
        disp("Derivate equal to 0, Newton method cannot continue");
        break
    end

    xk_next = xk - sol/F_sol;
    tries(k, :) = [xk, sol];

    %We change xk for xk_next
    xk_ant = xk;
    xk = xk_next;
    
    %We check if we've met any tolerance
    if abs(xk-xk_ant) < tol1 || abs(F_sol) < tol2
        sol_ant = 2*xk_ant^(3)-3*xk_ant^(2)+3;
        h = abs(sol-sol_ant);
        disp("Stopped at iteration number: "+ NTiter);
        break
    end
    disp("Iteration number: "+ NTiter);
end
%Just get the different xk's we've obtained
tries = tries(1:NTiter, :);
end