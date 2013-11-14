function [rDroplet, tDroplet] = calculateDropSize(m_solt, S, T, tEnd)
%CalculateDropSize Calculates the drop size increase
%   Uses the Equation 5.26 and solves iteratively.
%
% Inputs:
%   m_solt: mass of solute (NaCl) [kg]
%   S: super saturaton [-]
%   T: ambient temperature [K]
%   tEnd: end time [s]
%
% Outputs:
%   rDroplet: droplet radius vector [um]
%   tDroplet: time vector [s]
%

% Constants
R_v = 461;             % gas constant [J/kg]
e_sInf = 609;         % saturation pressure [mb]
rho_l = 1000;         % density water [kg/m^3]
rho_solt = 2160;      % density NaCl [kg/m^3]
sigma = 0.0761;       % surface tension [N/m]
M_v = 18;             % molecular weight water [g/mol]
M_solt = 58.44;       % molecular weight NaCl [g/mol]
iConstant = 2;        % Van't Hoff Factor for NaCl [-]

% Paramters at T=273K
kappa = 2.4*10^-2;    % coefficeint of thermal conductivity [J/(m*s*K)]
D_v = 2.21*10^-5;      % coefficient of vapor diffusivity [m^2/s]
L_lv = 2.6*10^6;         % latent heat water [J/kg]

% radius of NaCl [m]
r_solt = (m_solt / (4 / 3 * pi * rho_solt))^(1/3);

% time
tDelta = 0.01;               % time step [s]
nIterations = tEnd / tDelta; % number of iterations [-]

% initialize
t0 = 0;
rValue = r_solt;
rValueVector = zeros(nIterations, 1)';

% solve Equation 5.26
for i=1:nIterations

    % Kelvin effect
    a = 2 * sigma / (rho_l * R_v * T);

    % mass of water
    m_w = 4 / 3 * pi * rho_l * (rValue^3);

    % number of moles water (n_w) and solute (n_s)
    n_w = m_w / M_v;
    n_s = iConstant * m_solt / M_solt;

    % saturation pressure with solute
    e_s = e_sInf * exp(a / rValue) * n_w / (n_w + n_s);

    % heat conduction (K) and diffusion (D) [s/m^2]
    K = L_lv^2 * rho_l / (T^2 * kappa * R_v);
    D = rho_l * R_v * T / (D_v * e_s);

    rValue = ((S - 1) / (K + D)) / rValue * tDelta + rValue;

    % convert from [m] to [um]
    rValueVector(i) = 1E6 * rValue;

    if rValue > 0.75*1E-6 && t0==0
        t0 = i * tDelta;
    end
end

% organize results
tDroplet = tDelta * (1:nIterations);
tDroplet = tDroplet(tDroplet > t0);
rDroplet = rValueVector(tDroplet > t0);

end
