function Bi_variate_Plot(f, x_range, y_range, tries, NTiter, gradient_norms)
    [X, Y] = meshgrid(x_range, y_range);
    %Adjust the values of Z so they are represented in a logarithmic way
    %because the function scalates very quickly for better visualization
    Z = log(1+f(X, Y));

    figure;
    contour(X, Y, Z, 20, 'LineWidth', 0.8);
    colormap jet;
    colorbar;
    
    % Adjust the color bar to display in a non logarithmic scale
    c = colorbar;
    og_ticks = c.Ticks;
    og_labels = exp(og_ticks) - 1;
    c.Ticks = og_ticks;
    c.TickLabels = arrayfun(@(x) sprintf('%.0e', x), og_labels, 'UniformOutput', false); % Format labels in scientific notation
    
    %Adjustments to the plot
    xlim([-10, 10]);
    ylim([-10, 10]);
    xlabel('x');
    ylabel('y');
    title('Colored Plot of the Rosenbrok function and the approximations');
    hold on;
    
    %Plot the different guesses
    x_points = tries(:, 1);
    y_points = tries(:, 2);
    z_points = f(x_points, y_points);
    plot3(x_points,y_points,z_points,'ro-', 'MarkerSize', 8, 'LineWidth', 1.5);

    legend('', 'Iteration Points');
    hold off
    
    disp(" ");
    disp("Press any key to see the error plot");
    pause;
    %Plot the error as the norm of the gradient in each iteration
    plot(gradient_norms);
    xline(0);
    yline(0);
    xlabel('Iteration');
    ylabel('Error');   
    title(sprintf('Plot of the error of the Rosenbrok function \n When starting from (934,-835)'));
    grid

end