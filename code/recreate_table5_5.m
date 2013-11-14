% Recreate Table 5.5 from Curry and Webster (1998)
%
% Team MechE
% SIO 217A
% Fall 2013
%


%% m = 1E-12 [g] = 1E-15 [kg]
table12T=[0.013 0.61 62 870 5900 14500 41500];
table12R=[1 2 4 10 20 30 50];

[resultValues12,timeValues12] = calculateDropSize(1E-15, 1 + 0.05/100, 273.15, 41500);
table12RInterpolated = interp1(table12T,table12R,timeValues12);
rmse12 = sqrt(mean((table12RInterpolated - resultValues12).^2));

plot(timeValues12,resultValues12,table12T,table12R);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('Estimated r(t)', 'Table 5.5 Values');
title('Droplet Size Growth in Time for m_{solt}=10^{-15}kg');


%% m = 1E-13 [g] = 1E-16 [kg]
table13T=[0.15 7 320 1800 7400 16000 43500];
table13R=[1 2 4 10 20 30 50];

[resultValues13,timeValues13] = calculateDropSize(1E-16,1+0.05/100,273.15,43500);
table13RInterpolated = interp1(table13T,table13R,timeValues13);
rmse13 = sqrt(mean((table13RInterpolated-resultValues13).^2));

figure;
plot(timeValues13,resultValues13,table13T,table13R);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('Estimated r(t)', 'Table 5.5 Values');
title('Droplet Size Growth in Time for m_{solt}=10^{-16}kg');


%% m = 1E-14 [g] = 1E-17 [kg]
table14T=[2.4 130 1000 2700 8500 17500 44500];
table14R=[1 2 4 10 20 30 50];

[resultValues14,timeValues14] = calculateDropSize(1E-17,1+0.05/100,273.15,44500);
table14RInterpolated = interp1(table14T,table14R,timeValues14);
rmse14 = sqrt(mean((table14RInterpolated-resultValues14).^2));

figure;
plot(timeValues14,resultValues14,table14T,table14R);
xlabel('Time (s)');
ylabel('r(t) (\mum)');
legend('Estimated r(t)', 'Table 5.5 Values');
title('Droplet Size Growth in Time for m_{solt}=10^{-17}kg');
