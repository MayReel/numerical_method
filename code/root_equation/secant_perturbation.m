function secant_perturbation()
    equation = input('Enter f(x) : ', 's');
    f = str2func(['@(x)' equation]);
    fprintf('Here is your function f(x) = %s\n', equation);
    
    x0 = input('Enter initial guess (x0) : ');
    perturbation = input('Enter perturbation value (delta_x) : ');
    epsilon_t = input('Enter required Relative Error : ');
    
    epsilon_a = 10e5;
    round = 0;
    
    fprintf('%-8s %-15s %-15s\n', 'Round', 'x_{i+1}', 'epsilon_a');
    fprintf('%-8s %-15s %-15s\n', '--------', '---------------', '---------------');
    while epsilon_a > epsilon_t
        f_x0 = f(x0);
        f_x1 = f(x0 + perturbation);

        % Avoid division by zero
        if abs(f_x1 - f_x0) == 0
            error('Division by zero detected: Perturbation results in no change in f(x).');
        end

        % Calculate next xi using Secant Method with Perturbation
        x1 = x0 - f_x0 * perturbation / (f_x1 - f_x0);

        % Calculate Relative Error
        epsilon_a = abs((x1 - x0) / x1) * 100;

        % Display results
        fprintf('%-8d %-15.6f %-15.6f\n', round + 1, x1, epsilon_a);

        % Update x0 for next iteration
        x0 = x1;
        round = round + 1;
    end

    % Plot the function and root
    x_vals = linspace(x0-2, x0+2, 1000); % Extend range for visualization
    y_vals = f(x_vals);
    figure;
    plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5); hold on;
    yline(0, 'k--');
    plot(x0, f(x0), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title('Secant Method with Perturbation graph');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end
