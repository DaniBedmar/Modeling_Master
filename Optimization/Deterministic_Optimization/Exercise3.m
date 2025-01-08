% Solving of problem 3

% Maximum Production Function p_j = P_j
% x := Vector of Allocated Water for each Company

function P = Pfunc(x)
    P(1) = 0.4 * (x(1) ^ 0.9);
    P(2) = 0.5 * (x(2) ^ 0.8);
    P(3) = 0.6 * (x(3) ^ 0.7);
end

% Production Cost Function

function C = Cfunc(x)
    Ptemp = Pfunc(x);

    C(1) = 3 * (Ptemp(1) ^ 1.3);
    C(2) = 5 * (Ptemp(2) ^ 1.2);
    C(3) = 6 * (Ptemp(3) ^ 1.15);
end

% Product Price Function

function c = cfunc(x)
    Ptemp = Pfunc(x);

    c(1) = 12 - Ptemp(1);
    c(2) = 20 - 1.5*Ptemp(2);
    c(3) = 28 - 2.5*Ptemp(3);
end

% Total Net Benefit Function TBN: R^3 -> R
% TBN = sum(from j = 1 to 3){ c_j*P_j - C_j }

function TBN = TBNfunc(x)
    Ptemp = Pfunc(x);
    Ctemp = Cfunc(x);
    ctemp = cfunc(x);

    TBN = dot(ctemp,Ptemp) - sum(Ctemp);
end

% Defining Constants and Constraints

% Flow of water minus reserved water Q-R (Maximum of water available for allocation)
QR = 50;

x0 = [QR/3, QR/3, QR/3]; % Initial Guess

watallcon = @(x) deal([],QR - sum(x)); % Water Allocation Constraints
% deal() returns two outputs

% Bounds for the allocated water

lowerb = [0,0,0];
upperb = [QR,QR,QR];


% Solving the non-linear constrained problem with fmincon

options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp'); % Set the options
[x_result, fval] = fmincon(@(x) -TBNfunc(x), x0, [], [], [], [], lowerb, upperb, watallcon, options);

% Evaluate the functions with the obtained results
Popt = Pfunc(x_result);   % Optimal productions
Copt = Cfunc(x_result);   % Optimal costs
copt = cfunc(x_result);   % Optimal prices
TNB_opt = -fval;       % Optimal Total Net Benefit

% Display results
fprintf('Optimal Water Allocations: x1 = %.2f, x2 = %.2f, x3 = %.2f\n', x_result(1), x_result(2), x_result(3));
fprintf('Optimal Productions: p1 = %.2f, p2 = %.2f, p3 = %.2f\n', Popt(1), Popt(2), Popt(3));
fprintf('Optimal Prices: c1 = %.2f, c2 = %.2f, c3 = %.2f\n', copt(1), copt(2), copt(3));
fprintf('Total Net Benefit = %.2f\n', TNB_opt);
