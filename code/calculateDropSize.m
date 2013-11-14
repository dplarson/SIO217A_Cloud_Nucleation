function [resultValues, timeValues] = calculateDropSize(initialMass, saturationRatio, temperature, finalTime)
%CalculateDropSize Calculates the drop size increase
%   Uses the Equation 5.26 and solves iteratively.
%
% Inputs:
%   initialMass: mass of solute base [kg]
%   saturationRatio: super saturaton [-]
%   temperature: ambient temperature [K]
%   finalTime: end time [s]
%
% Outputs:
%   resultValues: droplet radius vector [um]
%   timeValues: time vector [s]
%

% Constants
Rv = 461;             % gas constant [J/kg]
e_sInf = 609;         % saturation pressure [mb]
T = temperature;      % ambient temperature [K]
Rho_l = 1000;         % density water [kg/m^3]
Rho_solt = 2160;      % density NaCl [kg/m^3]
S = saturationRatio;  % super saturation [-]
Sigma = 0.0761;       % surface tension [N/m]
M_v = 18;             % molecular weight water [g/mol]
M_solt = 58.44;       % molecular weight NaCl [g/mol]
m_solt = initialMass; % mass NaCl [kg]
iConstant = 2;        % Van't Hoff Factor for NaCl [-]

% Paramters at T=273K
Kappa = 2.4*10^-2;    % coefficeint of thermal conductivity [J/(m*s*K)]
Dv = 2.21*10^-5;      % coefficient of vapor diffusivity [m^2/s]
L = 2.6*10^6;         % latent heat water [J/kg]

% radius of NaCl [m]
r_solt = (m_solt * 3 / (4 * pi * Rho_solt))^(1/3);

% time
deltaT = 0.01;                          % time step [s]
iterationNumber = finalTime / deltaT;   % number of iterations [-]

% initialize
t0=0;
rValue = r_solt;
rValueVector = zeros(iterationNumber,1)';

% solve Equation 5.26
for i=1:iterationNumber
    
    % Kelvin effect
    a = 2 * Sigma/(Rho_l * Rv * T);
    
    % mass of water
    m_w = 4 / 3 * pi * Rho_l * (rValue^3);
    
    % number of moles water (n_w) and solute (n_s)
    n_w = m_w/M_v;
    n_s = iConstant*m_solt/M_solt;
    
    % saturation pressure with solute
    myConstant = n_w/(n_w+n_s);
    e_s = e_sInf * exp(a/rValue) * myConstant;
    
    % heat conduction (K) and diffusion (D) [s/m^2]
    K = L^2 * Rho_l / (T^2 * Kappa * Rv);
    D = Rho_l * Rv * T / (Dv * e_s);
    
    ratio = (S - 1) / (K + D);
    rValue = (ratio / rValue) * deltaT + rValue;
    
    % convert from [m] to [um]
    rValueVector(i) = 1E6 * rValue;
    
    if rValue > 0.75*1E-6 && t0==0
        t0 = i * deltaT;
    end
end

% organize results
timeValues = deltaT*(1:iterationNumber);
timeValues = timeValues(timeValues > t0);
resultValues = rValueVector(timeValues > t0);

end
