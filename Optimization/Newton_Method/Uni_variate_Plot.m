function  Uni_variate_Plot(NTiter, tries)
dif = zeros(1,NTiter-1);
for i=2:1:NTiter
    dif(i-1) = abs(tries(i,2)-tries(i-1,2));
end

%Now we plot the function and the aproximations
syms x;
f = 2*x^(3)-3*x^(2)+3;
fplot(f,[-5,5])
hold on;

xks = (tries(:, 1));
yks = (tries(:, 2));
plot(xks,yks,'xk');

hold on;

ylim([-5,5]) 
xline(0);
yline(0);
grid

xlabel('x');
ylabel('y');
title(sprintf('Plot of 2x^3 - 3x^2 + 3 and the approximations made\nStarting from x = %.2f', xks(1:1)));

hold off;

disp(" ");
disp("Press any key to continue to the next plot...");
pause;
disp(" ");

plot(dif);
xline(0);
yline(0);
xlabel('Iteration');
ylabel('Error');
title(sprintf('Plot of the error of 2x^3 - 3x^2 + 3 \nStarting from x = %.2f', xks(1:1)));

grid

end