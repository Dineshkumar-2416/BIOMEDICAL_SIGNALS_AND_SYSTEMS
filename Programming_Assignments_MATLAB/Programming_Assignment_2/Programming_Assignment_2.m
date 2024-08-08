% ACTION POTENTIAL SIMULATION

% Initializing Constants
Erest = -68; % mV
EK = -74.7; % mV
ENa = 54.2; % mV
C = 1; % 10^-6F/cm2
GK = 12; % m/cm2
GNa = 30; % m/cm2
Vm0 = Erest;
dt = 0.01; % ms
tmax = 10; % ms
t = 0:dt:tmax;
n = zeros(size(t));
m = zeros(size(t));
h = zeros(size(t));
Vm = zeros(size(t));
gK = zeros(size(t));
gNa = zeros(size(t));
% Initializing Io_values and tPW_values
Io_values = [5, 25, 75]; % uA
tPW_values = [0.2, 0.8]; % ms
% Simulation loop
for Io = Io_values
for tPW = tPW_values
% Initializing values at t=0
Vm(1) = Vm0;
n(1) = 0.3;
m(1) = 0.065;
h(1) = 0.6;
% Stimulus current
Is = zeros(size(t));
Is(t > 0 & t < tPW) = Io;
% Simulation
for i = 2:length(t)
% Step 1: Calculating rate constants
v = Vm(i - 1) - Erest;
alpha_n = (0.01 * (10 - v)) / (exp((10 - v) / 10) - 1);
beta_n = 0.125 * exp(-v / 80);
alpha_m = (0.1 * (25 - v)) / (exp((25 - v) / 10) - 1);
beta_m = 4 * exp(-v / 18);
alpha_h = 0.07 * exp(-v / 20);
beta_h = 1 / (exp((30 - v) / 10) + 1);
% Step 2: Calculate changes in n, m, and h
delta_n = dt * (alpha_n * (1 - n(i - 1)) - beta_n * n(i - 1));
delta_m = dt * (alpha_m * (1 - m(i - 1)) - beta_m * m(i - 1));
delta_h = dt * (alpha_h * (1 - h(i - 1)) - beta_h * h(i - 1));
% Update n, m, and h
n(i) = n(i - 1) + delta_n;
m(i) = m(i - 1) + delta_m;
h(i) = h(i - 1) + delta_h;
% Step 3: Calculating ionic conductance and currents
gK(i) = GK * n(i)^4;
gNa(i) = GNa * m(i)^3 * h(i);
% Step 4: Calculating total current
IK = gK(i) * (Vm(i - 1) - EK);
INa = gNa(i) * (Vm(i - 1) - ENa);
IC = Is(i) - (IK + INa);
% Step 5: Calculating membrane voltage
delta_VM = (IC / C) * dt;
Vm(i) = Vm(i - 1) + delta_VM;
end
% Plotting results
figure;
subplot(3, 1, 1);
plot(t, Vm);
title(['Membrane Voltage (Io = ', num2str(Io), ', tPW = ', num2str(tPW), '
ms)']);
xlabel('Time (ms)');
ylabel('Vm (mV)');
subplot(3, 1, 2);
plot(t, gK);
title('Potassium Conductance (gK)');
xlabel('Time (ms)');
ylabel('gK (mS/cm^2)');
subplot(3, 1, 3);
plot(t, gNa);
title('Sodium Conductance (gNa)');
xlabel('Time (ms)');
ylabel('gNa (mS/cm^2)');
end
end