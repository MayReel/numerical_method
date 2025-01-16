function increment_search()
    equation = input('Enter f(x) : ', 's');
    equation = replace(equation, '^', '.^');
    equation = replace(equation, '*', '.*');
    equation = replace(equation, '/', './');
    f = str2func(['@(x)' equation]);
    fprintf('Here is your function f(x) = %s\n', equation);
    
    x0 = input('Enter initial guess (x0) : ');
    delta_x = input('Enter increment step size (delta_x) : ');
    epsilon_t = input('Enter required Relative Error : ');
    
    epsilon_a = 10e5;
    xi = x0;
    round = 0;
    
    fprintf('%-8s %-15s %-15s\n', 'Round', 'x_{i+1}', 'epsilon_a');
    fprintf('%-8s %-15s %-15s\n', '--------', '---------------', '---------------');
    while epsilon_a > epsilon_t
        fxi = f(xi);
        fxi_next = f(xi + delta_x);

        % Avoid division by zero
        if abs(fxi_next - fxi) == 0
            error('Division by zero detected: Increment step results in no change in f(x).');
        end

        % Calculate next xi using Increment Search
        xi_new = xi - fxi * delta_x / (fxi_next - fxi);

        % Calculate Relative Error
        epsilon_a = abs((xi_new - xi) / xi_new) * 100;

        % Display results
        fprintf('%-8d %-15.6f %-15.6f\n', round + 1, xi_new, epsilon_a);

        % Update xi and round
        xi = xi_new;
        round = round + 1;
    end

    % Plot the function and root
    x_vals = linspace(xi-2, xi+2, 1000); % Extend range for visualization
    y_vals = f(x_vals);
    figure;
    plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5); hold on;
    yline(0, 'k--');
    plot(xi, f(xi), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title('Increment Search Method graph');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end
