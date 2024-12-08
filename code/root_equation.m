clc;
disp('Choose function : ');
disp('1. test Bisection Method example in class');
disp('2. test Bisection Method example in class(non-linear)');
disp('3. test False-Position Method in class');
disp('4. test False-Position Method in class(non-linear)');
disp('5. test Bisection Method solver');
disp('6. test False-Postion Method solver');
f = input('Enter number function : ');

switch f
    case 1
        bisec_class_example();
    case 2
        bisec_class_example_non_linear();
    case 3 
        false_position_example();
    case 4
        false_position_example_non_linear();
    case 5
        bisec_general();
    case 6
        false_position_general();
    otherwise
        disp('LLLLLLLLLLLLLLLL');
end


   

function bisec_class_example()
    % Define the function to find the root
    f = @(x) x.^2 + 2.*x - 3;

    xl = -5; %lower bound
    xu = -2; %upper bound

    %root solution is exist?
    if f(xl) * f(xu) > 0
        error('WTF?');
    end

    %init value
    epsilon_t = 1; %acceptable value
    epsilon_a = 10e5;   %relative error value
    term = 0;        %term
    xr_old = 0;  

    % Print header for the output table
    fprintf('Term    xl\t\t f(xl)\t\t xu\t\t\t f(xu)\t\t xr\t\t\t f(xr)\t\t epsilon\n');
    fprintf('------------------------------------------------------------------------------------------\n');
    
    % Start the bisection method loop
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
    x = linspace(-6, 0, 1000); 
    y = f(x); 

    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5); hold on; 
    yline(0, 'k--', 'LineWidth', 1); 
    plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 2); 

    % Title and labels
    title('Bisection of $$f(x) = x^2 + 2x - 3$$', 'interpreter', 'latex');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end

function bisec_class_example_non_linear()
    % Define the function to find the root
    f = @(x) ((9.8*68.1)./x) .* (1 - exp(-((x/68.1)*10))) - 40;
    xl = 12;
    xu = 16;
    
    epsilon_t = 0.2;
    epsilon_a = 1;
    xr_old = 0;
    term = 0;
    
    % Print header for the output table
    fprintf('Term    xl\t\t f(xl)\t\t xu\t\t\t f(xu)\t\t xr\t\t\t f(xr)\t\t epsilon\n');
    fprintf('------------------------------------------------------------------------------------------\n');
    while epsilon_a > epsilon_t
        xr = (xl+xu) / 2;
        fxr = f(xr);
        fxl = f(xl);
        fxu = f(xu);
        
        if fxl * fxr < 0
            xu = xr;
        else
            xl = xr;
        end
        
        epsilon_a = abs(xr-xr_old)/xr * 100;
        
        fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            term + 1, xl, fxl, xu, fxu, xr, fxr, epsilon_a);
        xr_old = xr;
        term = term + 1;
    end
    
    % Plot the function and the root found
    x = linspace(1, 100, 1000); % Update range for x to match xl and xu
    y = f(x); 

    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5); hold on; 
    yline(0, 'k--', 'LineWidth', 1); 
    plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 2); 
    
    
    % Title and labels
    title('Bisection Method of $$ f(x) = \frac{9.8(68.1)}{x}(1-e^{-(68.1)10})-40 $$', 'interpreter', 'latex', 'FontSize', 15);
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end

function false_position_example()
    f = @(x) x.^2 + 2.*x - 3;
    
    xl = -5;
    xu = -2;
    
    % Initial values
    epsilon_t = 1;    % Target
    epsilon_a = 10e5; % Large initial error
    term = 0;
    xr_old = 0;
    
    fprintf('Term    xl\t\t f(xl)\t\t xu\t\t\t f(xu)\t\t xr\t\t\t f(xr)\t\t epsilon\n');
    fprintf('------------------------------------------------------------------------------------------\n');
    while epsilon_a > epsilon_t
        fxl = f(xl);
        fxu = f(xu);
        
        % Avoid division by zero
        if abs(fxl - fxu) == 0
            error('Division by zero detected: f(xl) and f(xu) are too close.');
        end
        
        % Calculate xr
        xr = xu - ((fxu * (xl - xu)) / (fxl - fxu));
        fxr = f(xr);
        
        % Update xl or xu
        if fxl * fxr < 0
            xu = xr;
        else
            xl = xr;
        end
        
        % Calculate Relative Error
        epsilon_a = abs((xr - xr_old) / xr) * 100;
        
        % Display results
        fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            term + 1, xl, fxl, xu, fxu, xr, fxr, epsilon_a);
        
        % Update old xr
        xr_old = xr;
        term = term + 1;
    end

    % Plot the function and root
    x = linspace(-6, 2, 1000);
    y = f(x);
    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5); hold on;
    yline(0, 'k--');
    plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title('False-Position Method of $$f(x) = x^2 + 2x - 3$$', 'interpreter', 'latex');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end


function false_position_example_non_linear()
    f = @(x) ((9.8*68.1)./x) .* (1 - exp(-((x/68.1)*10))) - 40;
    
    xl = 12;
    xu = 16;
    
    % Initial values
    epsilon_t = 0.2;    % Target
    epsilon_a = 10e5; % Large initial error
    term = 0;
    xr_old = 0;
    
    fprintf('Term    xl\t\t f(xl)\t\t xu\t\t\t f(xu)\t\t xr\t\t\t f(xr)\t\t epsilon\n');
    fprintf('------------------------------------------------------------------------------------------\n');
    while epsilon_a > epsilon_t
        fxl = f(xl);
        fxu = f(xu);
        
        % Avoid division by zero
        if abs(fxl - fxu) == 0
            error('Division by zero detected: f(xl) and f(xu) are too close.');
        end
        
        % Calculate xr
        xr = xu - ((fxu * (xl - xu)) / (fxl - fxu));
        fxr = f(xr);
        
        % Update xl or xu
        if fxl * fxr < 0
            xu = xr;
        else
            xl = xr;
        end
        
        % Calculate Relative Error
        epsilon_a = abs((xr - xr_old) / xr) * 100;
        
        % Display results
        fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            term + 1, xl, fxl, xu, fxu, xr, fxr, epsilon_a);
        
        % Update old xr
        xr_old = xr;
        term = term + 1;
    end

    % Plot the function and root
    x = linspace(-6, 2, 1000); % Extend range for visualization
    y = f(x);
    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5); hold on;
    yline(0, 'k--');
    plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title('False Position Method of $$ f(x) = \frac{9.8(68.1)}{x}(1-e^{-(68.1)10})-40 $$', 'interpreter', 'latex', 'FontSize', 15);
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end

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

function false_position_general()
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
    xr_old = 0;
    term = 0;
    
    fprintf('Term    xl\t\t f(xl)\t\t xu\t\t\t f(xu)\t\t xr\t\t\t f(xr)\t\t epsilon\n');
    fprintf('------------------------------------------------------------------------------------------\n');
    while epsilon_a > epsilon_t
        fxl = f(xl);
        fxu = f(xu);
        
        % Avoid division by zero
        if abs(fxl - fxu) == 0
            error('Division by zero detected: f(xl) and f(xu) are too close.');
        end
        
        % Calculate xr
        xr = xu - ((fxu * (xl - xu)) / (fxl - fxu));
        fxr = f(xr);
        
        % Update xl or xu
        if fxl * fxr < 0
            xu = xr;
        else
            xl = xr;
        end
        
        % Calculate Relative Error
        epsilon_a = abs((xr - xr_old) / xr) * 100;
        
        % Display results
        fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            term + 1, xl, fxl, xu, fxu, xr, fxr, epsilon_a);
        
        % Update old xr
        xr_old = xr;
        term = term + 1;
    end

    % Plot the function and root
    x = linspace(xl-2, xu+2, 1000); % Extend range for visualization
    y = f(x);
    figure;
    plot(x, y, 'b-', 'LineWidth', 1.5); hold on;
    yline(0, 'k--');
    plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    title('False Position Method graph');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    hold off;
end
