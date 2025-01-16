function secant_general()
    equation = input('Enter f(x) : ', 's');
    equation = replace(equation, '^', '.^');
    equation = replace(equation, '*', '.*');
    equation = replace(equation, '/', './');
    f = str2func(['@(x)' equation]);
    fprintf('Here is your function f(x) = %s\n', equation);
    
    x0 = input('Enter first initial guess (x0) : ');
    x1 = input('Enter second initial guess (x1) : ');
    epsilon_t = input('Enter required Relative Error : ');
    
    epsilon_a = 10e5;
    round = 0;
    
    fprintf('%-8s %-15s %-15s\n', 'Round', 'x_{i+1}', 'epsilon_a');
    fprintf('%-8s %-15s %-15s\n', '--------', '---------------', '---------------');
    while epsilon_a > epsilon_t
        f_x0 = f(x0);
        f_x1 = f(x1);

        % Avoid division by zero
        if abs(f_x1 - f_x0) == 0
            error('Division by zero detected: f(x1) and f(x0) are too close.');
        end

        % Calculate next xi using Secant Method
        x2 = x1 - f_x1 * (x1 - x0) / (f_x1 - f_x0);

        % Calculate Relative Error
        epsilon_a = abs((x2 - x1) / x2) * 100;

        % Display results
        fprintf('%-8d %-15.6f %-15.6f\n', round + 1, x2, epsilon_a);

        % Update guesses for next iteration
        x0 = x1;
        x1 = x2;
        round = round + 1;
    end

    % Plot the function and root
    x_vals = linspace(x1-2, x1+2, 1000); % Extend range for visualization
    y_vals = f(x_vals);
    figure;
    plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5); hold on;
    yline(0, 'k--');
    plot(x1, f(x1), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title('Secant Method graph');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end
