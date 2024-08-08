DISCRETE CONVOLUTION
% Convolution of x[n] and h[n]
% Defining the lengths of signals
N = 5;
M = 3;
% Defining the input signal x[n]
input_signal = [1, 2, 3, 1, 0];
% Defining the impulse response h[n]
impulse_response = [1, -1, 2];
% Initializing the output signal y[n] with zeros
output_signal = zeros(1, N + M - 1);
% Plotting the initial y[n] signal (all zeros)
figure;
stem(output_signal);
title('Initial y[n] (before convolution)');
xlabel('n');
ylabel('y[n]');
% Performing convolution
for n = 1:N + M - 1
for k = max(1, n - M + 1):min(n, N)
output_signal(n) = output_signal(n) + input_signal(k) * impulse_response(n
- k + 1);
end
end
% Defining time indices
time_indices_x = 0:N - 1;
time_indices_h = 0:M - 1;
time_indices_y = 0:N + M - 2;
% Plotting the input signal x[n]
figure;
subplot(3, 1, 1);
stem(time_indices_x, input_signal, 'b', 'LineWidth', 1.5);
title('Input Signal x[n]');
xlabel('n');
ylabel('x[n]');
grid on;
% Plotting the impulse response h[n]
subplot(3, 1, 2);
stem(time_indices_h, impulse_response, 'r', 'LineWidth', 1.5);
title('Impulse Response h[n]');
xlabel('n');
ylabel('h[n]');
grid on;
% Plotting the convolution output y[n]
subplot(3, 1, 3);
stem(time_indices_y, output_signal, 'g', 'LineWidth', 1.5);
title('Convolution Output y[n]');
xlabel('n');
ylabel('y[n]');
grid on;
% Convolution of x[n] and h[n]
sgtitle('Convolution of x[n] and h[n]');