function bisec_general()
    equation = input('Enter f(x) : ', 's');
    f = str2func(['@(x)' equation]);
    fprintf('Here is your function f(x) = %s\n', equation);
    
    xl = input('Enter lower bound (xl) : ');
    xu = input('Enter lower bound (xu) : ');
    
    epsilon_t = input('Enter require Relative Error : ');
    
    if f(xl) * f(xu) > 0
        error('Cannot find root');
    end
    
    epsilon_a = 10e5;
    term = 0;
    xr_old = 0;
    
    fprintf('Term    xl\t\t f(xl)\t\t xu\t\t\t f(xu)\t\t xr\t\t\t f(xr)\t\t epsilon\n');
    fprintf('------------------------------------------------------------------------------------------\n');
    
    while epsilon_a > epsilon_t
        % Calculate the midpoint xr
        xr = (xl + xu) / 2;
        fxr = f(xr);
        fxl = f(xl);
        fxu = f(xu);
        
        % Print the current step's information
        
        
        % Update lower or upper bound
        if fxr * fxl < 0
            xu = xr;
        else
            xl = xr;
        end
        
        % Relative Error
        
        epsilon_a = abs((xr - xr_old) / xr) * 100;
        
        fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            term + 1, xl, fxl, xu, fxu, xr, fxr, epsilon_a);
        xr_old = xr;
        term = term + 1;
    end

    % Plot the function and the root found
    x = linspace(xl-2, xu+2, 1000); 
    y = f(x); 

    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5); hold on; 
    yline(0, 'k--', 'LineWidth', 1); 
    plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 2); 

    % Title and labels
    title('Bisection Method graph');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end