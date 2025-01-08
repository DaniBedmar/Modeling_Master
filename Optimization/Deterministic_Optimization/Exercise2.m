M = 100;     
alpha = 0.2; 


I = @(x) x .* M .* exp(-alpha .* x);


x_optimal = fminbnd(@(x) -I(x), 0, 100);
max_tax = I(x_optimal);                 

fprintf('Optimal inflation rate (numerical): %.4f\n', x_optimal);
fprintf('Maximum inflationary tax: %.4f euros\n', max_tax);

%crear valors per el plot
x_values = linspace(0, 100, 500); 
I_values = I(x_values);           

figure;
plot(x_values, I_values, 'b-', 'LineWidth', 2); % Dibuixar la tax function
hold on;
plot(x_optimal, max_tax, 'ro', 'MarkerSize', 10); % Marcar el punt optim
grid on;
xlabel('Inflation Rate (x)');
ylabel('Inflationary Tax (I)');
title('Inflationary Tax vs. Inflation Rate');
legend('Tax Function', 'Maximum');

