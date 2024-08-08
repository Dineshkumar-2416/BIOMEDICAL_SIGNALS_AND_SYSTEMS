% Initialization
M_value = 50;
SamplingFrequency = 2000;
SignalFrequency = 5;
SignalDuration = 0.5;
% Time vector
n = 0:M_value - 1;
% Defining the impulse response h[n]
h_n = (0.42 - 0.5 * cos(2 * pi * n / M_value) + 0.08 * cos(4 * pi * n /
M_value)) / 20.58;
% Defining the input signal x[n]
t = 0:1/SamplingFrequency:SignalDuration-1/SamplingFrequency;
x_n = sin(2 * pi * SignalFrequency * t);
% Initialize the output signal y[n] with zeros
y_n = zeros(1, length(x_n) + length(h_n) - 1);
% Performing convolution using nested loops
for k = 1:length(y_n)
y_n(k) = 0; % Initialize y[n] at each time index
% Computing the convolution sum for y[n]
for j = 1:length(h_n)
if k - j + 1 > 0 && k - j + 1 <= length(x_n)
y_n(k) = y_n(k) + x_n(k - j + 1) * h_n(j);
end
end
end
% Plotting input signal x[n]
figure;
subplot(3, 1, 1);
stem(t, x_n);
title('Input Signal x[n]');
% Plotting impulse response h[n]
subplot(3, 1, 2);
stem(0:M_value-1, h_n);
title('Impulse Response h[n]');
% Plotting convolution output y[n]
n_y_n = 0:length(y_n)-1;
subplot(3, 1, 3);
stem(n_y_n, y_n);
title('Convolution Output y[n]');
xlim([0, length(y_n)]);
% Calculating the gain of the system
system_gain = sum(abs(y_n)) / sum(abs(x_n));
disp(['The gain of the system is: ' num2str(system_gain)]);