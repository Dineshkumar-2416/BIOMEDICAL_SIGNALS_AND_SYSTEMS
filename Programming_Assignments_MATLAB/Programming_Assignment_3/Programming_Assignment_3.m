clear all;
close all;
clc;

function delta_signal = discrete_delta(n, n0)
%n is the input time and n0 is the values of np
 delta_signal = zeros(size(n));
 for i = 1:length(n)
  for j= 1:length(n0)
   if n(i)==n0(j)
   delta_signal(i) = 1;
   end
  end
 end
end   

% Define parameters
theta = 0.005; % Nerve conduction delay in seconds
G = 30; % N/Hz
a = 5; % 1/s
b = 20; % 1/s
T = 0.0001; % Sampling time in seconds
% Define time vector and sampling points
t = 0:T:1; % Time vector for 0.1 seconds
n=0:1:1/T;
% Initialize arrays to store the output force and impulse response
force_single = zeros(size(t));
impulse_response = zeros(size(n));
np = [0/0.0001];
% Simulate the system for two impulses 200 ms apart
% Calculate impulse response s[n]
impulse_response = discrete_delta(n,np);
% Calculate nerve conduction delay g[n]
m=theta/T;
g=zeros(size(n));
g(m+1:end) = impulse_response(1:end-m);
fh=zeros(size(n)); 
for i = 1:length(t)
 fh(i) = G * (exp(-a*t(i)) - exp(-b*t(i))) * (t(i) >= 0);
end
% % Calculate cumulative force f[n]
force_single = discreteconvolution(n,fh,g);
% % % Plot the results
figure();
subplot(2,1,1);
plot(t, impulse_response)
title('Impulse response s[n]');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2);
plot(t, g)
title('Delayed Impulse response g[n]');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(t, force_single);
title('Output Force for single twitch');
xlabel('Time (s)');
ylabel('Force (N)');