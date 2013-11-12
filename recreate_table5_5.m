% Team MechE
% SIO 217A
% Fall 2013


%% Problem Statement
% Reproduce Table 5.5 from modeling Eqn. 5.26. Then use relevant ranges of 
% temperature and supersaturation to do sensitivity tests.


%% Solution

% Constants
r0 = 0.75E-6;        % initial radius [m]
S_1 = 0.05;          % (S - 1) [-]
T = 273;             % temperature [K]
p = 900;             % pressure [mb=hPa]
R_v = 461;           % gas constant [J/(kg*K)]
rho_l = 1000;        % density of water [kg/m^3]

% Parameters at T=0 degrees C
L_lv = 2.50E6;             % latent heat of water [J/kg]
e_s = 12.3 / 2;            % saturation pressure [mb=hPa]
kappa = 2.40E-2;           % thermal conductivity [J/(m*s*K)]
D_v = 2.21E-5 * 1000 / p;  % diffusion coeff [m^2/s] at p=900mb

% Paramaters
r = [1, 2, 4, 10, 20, 30, 50] .* 1E-6;  % radius [m]
m_salt = 1E-14 / 1E3;                   % mass [kg]

% Saturation pressure as function of r and m
sigma_lv = 0.0761 - 1.55E-4 * (T - 273.0);  % Equation 5.7 (requires T in degrees C)
MW_salt = 58.44;                            % molecular weight NaCl [g/mol]
MW_water = 18.02;                           % molecular weight H20 [g/mol]
i = 3;
a = 2 * sigma_lv / (rho_l * R_v * T);
b = 3 * i * MW_water * m_salt / (4 * pi * MW_salt * rho_l);

e_s_salt = e_s .* (1 + (a ./ r) - (b ./ r.^3));
%e_s_salt = e_s .* ((1 - b ./ r.^3) .* exp(a ./ r));
%e_s_salt = e_s .*(1 - (b ./ r.^3));

% Solve Equation 5.27 for t (assume t0=0)
K = L_lv^2 .* rho_l ./ (kappa .* R_v .* T.^2);
D = rho_l .* R_v * T ./ (e_s_salt .* D_v);
t = (r.^2 - r0^2) .* (K + D) ./ (2 .* S_1);


%% True values (from Table 5.5)

% mass = 1E-14 [g]
t_true_14 = [2.4, 130, 1E3, 2.7E3, 8.5E3, 17.5E3, 44.5E3];

% mass = 1E-13 [g]
t_true_13 = [0.15, 7.0, 320, 1.8E3, 7.4E3, 16.0E3, 43.5E3];

% mass = 1E-12 [g]
t_true_12 = [0.013, 0.61, 62, 870, 5.9E3, 14.5E3, 41.5E3];


%% Plot
figure
hold on

plot(t, r * 1E6, '-ok', 'markerface', 'k')
plot(t_true_14, r * 1E6, '-or', 'markerface', 'r')
plot(t_true_13, r * 1E6, '-og', 'markerface', 'g')
plot(t_true_12, r * 1E6, '-ob', 'markerface', 'b')

xlabel('t [s]')
ylabel('r [um]')

legend({'Estimate for 1E-14', '1E-14', '1E-13', '1E-12'}, ...
    'Location', 'NorthOutside', ...
    'Orientation', 'Horizontal')