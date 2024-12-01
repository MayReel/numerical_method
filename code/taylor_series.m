x = input('Stopping error : ');

expro = exp(0.5);
epsilon_t = 100; %ค่าเปอร์เซ็นคลาดเคลื่อนเริ่มต้น
app_err = x; %ค่าที่เราต้องการให้หยดุ
approx_sum = 0; %ผลรวมของอนุกรม Taylor ในแต่ละเทอม
n = 0; % จำนวน term
matrix_approx = [];
while epsilon_t > app_err
    term = (0.5^n)/(factorial(n));
    approx_sum = approx_sum + term;
    matrix_approx(end+1) = term;
    epsilon_t = abs((expro-approx_sum)/expro) * 100;
    n = n+1;
    fprintf('Number of terms: %d, Result: %.8f, Error: %.8f\n', n, approx_sum, epsilon_t);
end

fprintf('-------------------------------------\n')


epsilon_a = 100; %ค่าเปอร์เซ็นคลาดเคลื่อนเริ่มต้นของ Relative Error
approx_sum2_init = 0; %ค่าเก่า
approx_sum2_end = 0; %ค่าใหม่
n1 = 0; %จำนวน term
while epsilon_a > app_err
    approx_sum2_end = approx_sum2_init + ((0.5^n1)/factorial(n1));
    if n1 > 0
        epsilon_a = abs((approx_sum2_end - approx_sum2_init) / approx_sum2_end)*100;
    end
    fprintf('Number of terms: %d, Approximation: %.8f, Relative Error: %.8f\n', ...
            n1 + 1, approx_sum2_end, epsilon_a);
    approx_sum2_init = approx_sum2_end;
    n1 = n1 + 1;
end

fprintf('-------------------------------------\n')

fprintf('Each term of Taylor series is : [')
fprintf('%.8f, ', matrix_approx(1:end-1))
fprintf('%.8f]', matrix_approx(end))