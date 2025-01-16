clc;
disp('Choose function : ');
disp('1. test Newton Raphson Solution');
disp('2. test Bisection Method Solution');
disp('3. test False-Position Method Solution');
disp('4. test Increment Search Solution');
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
    otherwise
        disp('LLLLLLLLLLLLLLLL');
end