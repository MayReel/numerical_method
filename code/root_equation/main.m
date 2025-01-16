clc;
disp('Choose function : ');
disp('1. test Newton Raphson Solution');
disp('2. test Bisection Method Solution');
disp('3. test False-Position Method Solution');
disp('4. test Increment Search Solution');
disp('5. test Secant Method Solution');
disp('6. test Secant Method Solution (perturbation)');
f = input('Enter number function : ');

switch f
    case 1
        newton_raphson_general();
    case 2
        bisec_general();
    case 3 
        false_position_general();
    case 4
        increment_search();
    case 5
        secant_general();
    case 6
        secant_perturbation();
    otherwise
        disp('LLLLLLLLLLLLLLLL');
end