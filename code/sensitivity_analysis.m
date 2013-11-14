% Analysis sensitivity of droplet growth rate to temperature and saturation.
%
% Team MechE
% SIO 217A
% Fall 2013
%


%% Temperature Sensitivity Analysis

% m = 1E-12 [g] = 1E-15 [kg]
[resultValues12_0,timeValues12_0] = calculateDropSize(10^-15,1+0.05/100,273.15,41500);
[resultValues12_10,timeValues12_10] = calculateDropSize(10^-15,1+0.05/100,273.15+10,41500);
[resultValues12_20,timeValues12_20] = calculateDropSize(10^-15,1+0.05/100,273.15+20,41500);
[resultValues12_30,timeValues12_30] = calculateDropSize(10^-15,1+0.05/100,273.15+30,41500);
[resultValues12_40,timeValues12_40] = calculateDropSize(10^-15,1+0.05/100,273.15+40,41500);
[resultValues12_50,timeValues12_50] = calculateDropSize(10^-15,1+0.05/100,273.15+50,41500);

% m = 1E-13 [g] = 1E-16 [kg]
[resultValues13_0,timeValues13_0] = calculateDropSize(10^-16,1+0.05/100,273.15,43500);
[resultValues13_10,timeValues13_10] = calculateDropSize(10^-16,1+0.05/100,273.15+10,43500);
[resultValues13_20,timeValues13_20] = calculateDropSize(10^-16,1+0.05/100,273.15+20,43500);
[resultValues13_30,timeValues13_30] = calculateDropSize(10^-16,1+0.05/100,273.15+30,43500);
[resultValues13_40,timeValues13_40] = calculateDropSize(10^-16,1+0.05/100,273.15+40,43500);
[resultValues13_50,timeValues13_50] = calculateDropSize(10^-16,1+0.05/100,273.15+50,43500);

% m = 1E-14 [g] = 1E-17 [kg]
[resultValues14_0,timeValues14_0] = calculateDropSize(10^-17,1+0.05/100,273.15,44500);
[resultValues14_10,timeValues14_10] = calculateDropSize(10^-17,1+0.05/100,273.15+10,44500);
[resultValues14_20,timeValues14_20] = calculateDropSize(10^-17,1+0.05/100,273.15+20,44500);
[resultValues14_30,timeValues14_30] = calculateDropSize(10^-17,1+0.05/100,273.15+30,44500);
[resultValues14_40,timeValues14_40] = calculateDropSize(10^-17,1+0.05/100,273.15+40,44500);
[resultValues14_50,timeValues14_50] = calculateDropSize(10^-17,1+0.05/100,273.15+50,44500);

figure;
subplot(3,1,1);
plot(timeValues12_0,resultValues12_0,...
     timeValues12_10,resultValues12_10,...
     timeValues12_20,resultValues12_20,...
     timeValues12_30,resultValues12_30,...
     timeValues12_40,resultValues12_40,...
     timeValues12_50,resultValues12_50);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('r(t) T=273.15K', 'r(t) T=283.15K', 'r(t) T=293.15K', 'r(t) T=303.15K', 'r(t) T=313.15K', 'r(t) T=323.15K');
title('Temperature Sensitivity of Droplet Size Growth in Time for m_{solt}=10^{-15}kg');

subplot(3,1,2);
plot(timeValues13_0,resultValues13_0,...
     timeValues13_10,resultValues13_10,...
     timeValues13_20,resultValues13_20,...
     timeValues13_30,resultValues13_30,...
     timeValues13_40,resultValues13_40,...
     timeValues13_50,resultValues13_50);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('r(t) T=273.15K', 'r(t) T=283.15K', 'r(t) T=293.15K', 'r(t) T=303.15K', 'r(t) T=313.15K', 'r(t) T=323.15K');
title('Temperature Sensitivity of Droplet Size Growth in Time for m_{solt}=10^{-16}kg');

subplot(3,1,3);
plot(timeValues14_0,resultValues14_0,...
     timeValues14_10,resultValues14_10,...
     timeValues14_20,resultValues14_20,...
     timeValues14_30,resultValues14_30,...
     timeValues14_40,resultValues14_40,...
     timeValues14_50,resultValues14_50);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('r(t) T=273.15K', 'r(t) T=283.15K', 'r(t) T=293.15K', 'r(t) T=303.15K', 'r(t) T=313.15K', 'r(t) T=323.15K');
title('Temperature Sensitivity of Droplet Size Growth in Time for m_{solt}=10^{-17}kg');


%% Saturation Sensitivity Analysis
[resultValues12_S0,timeValues12_S0] = calculateDropSize(10^-15,1+0.05/100,273.15,41500);
[resultValues12_S10,timeValues12_S10] = calculateDropSize(10^-15,1+0.05/100+0.05/100,273.15,41500);
[resultValues12_S20,timeValues12_S20] = calculateDropSize(10^-15,1+0.05/100+0.10/100,273.15,41500);
[resultValues12_S30,timeValues12_S30] = calculateDropSize(10^-15,1+0.05/100+0.15/100,273.15,41500);
[resultValues12_S40,timeValues12_S40] = calculateDropSize(10^-15,1+0.05/100+0.20/100,273.15,41500);
[resultValues12_S50,timeValues12_S50] = calculateDropSize(10^-15,1+0.05/100+0.25/100,273.15,41500);

[resultValues13_S0,timeValues13_S0] = calculateDropSize(10^-16,1+0.05/100,273.15,43500);
[resultValues13_S10,timeValues13_S10] = calculateDropSize(10^-16,1+0.05/100+0.05/100,273.15,43500);
[resultValues13_S20,timeValues13_S20] = calculateDropSize(10^-16,1+0.05/100+0.10/100,273.15,43500);
[resultValues13_S30,timeValues13_S30] = calculateDropSize(10^-16,1+0.05/100+0.15/100,273.15,43500);
[resultValues13_S40,timeValues13_S40] = calculateDropSize(10^-16,1+0.05/100+0.20/100,273.15,43500);
[resultValues13_S50,timeValues13_S50] = calculateDropSize(10^-16,1+0.05/100+0.25/100,273.15,43500);

[resultValues14_S0,timeValues14_S0] = calculateDropSize(10^-17,1+0.05/100,273.15,44500);
[resultValues14_S10,timeValues14_S10] = calculateDropSize(10^-17,1+0.05/100+0.05/100,273.15,44500);
[resultValues14_S20,timeValues14_S20] = calculateDropSize(10^-17,1+0.05/100+0.10/100,273.15,44500);
[resultValues14_S30,timeValues14_S30] = calculateDropSize(10^-17,1+0.05/100+0.15/100,273.15,44500);
[resultValues14_S40,timeValues14_S40] = calculateDropSize(10^-17,1+0.05/100+0.20/100,273.15,44500);
[resultValues14_S50,timeValues14_S50] = calculateDropSize(10^-17,1+0.05/100+0.25/100,273.15,44500);

figure;
subplot(3,1,1);
plot(timeValues12_S0,resultValues12_S0,...
     timeValues12_S10,resultValues12_S10,...
     timeValues12_S20,resultValues12_S20,...
     timeValues12_S30,resultValues12_S30,...
     timeValues12_S40,resultValues12_S40,...
     timeValues12_S50,resultValues12_S50);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('r(t) S-1=0.05%', 'r(t) S-1=0.10%', 'r(t) S-1=0.15%', 'r(t) S-1=0.20%', 'r(t) S-1=0.25%', 'r(t) S-1=0.30%');
title('Saturation Ratio Sensitivity of Droplet Size Growth in Time for m_{solt}=10^{-15}kg');

subplot(3,1,2);
plot(timeValues13_S0,resultValues13_S0,...
     timeValues13_S10,resultValues13_S10,...
     timeValues13_S20,resultValues13_S20,...
     timeValues13_S30,resultValues13_S30,...
     timeValues13_S40,resultValues13_S40,...
     timeValues13_S50,resultValues13_S50);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('r(t) S-1=0.05%', 'r(t) S-1=0.10%', 'r(t) S-1=0.15%', 'r(t) S-1=0.20%', 'r(t) S-1=0.25%', 'r(t) S-1=0.30%');
title('Saturation Ratio Sensitivity of Droplet Size Growth in Time for m_{solt}=10^{-16}kg');

subplot(3,1,3);
plot(timeValues14_S0,resultValues14_S0,...
     timeValues14_S10,resultValues14_S10,...
     timeValues14_S20,resultValues14_S20,...
     timeValues14_S30,resultValues14_S30,...
     timeValues14_S40,resultValues14_S40,...
     timeValues14_S50,resultValues14_S50);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('r(t) S-1=0.05%', 'r(t) S-1=0.10%', 'r(t) S-1=0.15%', 'r(t) S-1=0.20%', 'r(t) S-1=0.25%', 'r(t) S-1=0.30%');
title('Saturation Ratio Sensitivity of Droplet Size Growth in Time for m_{solt}=10^{-17}kg');
