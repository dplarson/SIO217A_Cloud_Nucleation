"""
Droplet growth rate.

Team MechE, SIO 217A, Fall 2013

"""

import numpy as np
import matplotlib.pyplot as plt


def calculate_radius(m, t, r0=0.75, T=273.0, p=900.0):
    """
    Calculate droplet radius using Equation 5.26 of Curry.

    Parameters
    ----------
    m : float
        Mass of nucleus [kg].
    t : ndarray
        Time vector [s].
    r0 : float
        Initial radius [um].
    T : float
        Ambient temperature [K].
    p : float
        Ambient pressure [mb].


    Returns
    -------
    r : ndarray
        Droplet radius as function of time [um].

    """

    S_1 = 0.05 / 100.0  # supersaturation [-]
    R = 8.314  # universal gas constant [J/(mol*K)]

    # properties of the liquid (water)
    M = 18.01528E-3  # molecular weight [kg/mol]
    rho_l = 1.0E3  # density of water [kg/m^3]
    sigma_lv = 0.0761 - 1.55E-4 * (T - 273.0)

    # properties of the nucleus (NaCl)
    W = 58.44E-3  # molecular weight [kg/mol]
    i = 2.0  # Van't Hoff Factor [-]

    # properties dependent at temperature (T = 273 [K])
    L_lv = 2.5E6  # latent heat [J/kg]
    kappa = 2.4E-2  # coeff of thermal conductivity [J/(m*s*K)]
    D_v = 2.21E-5 * (1000.0 / p)  # coeff of diffusivity [m^2/s]
    e_s = 12.3 / 2.0 * 1.0E2  # saturation pressure [Pa]

    # initialize
    r = np.zeros(len(t))
    r[0] = r0 / 1.0E6

    # numerically solve
    for i in range(1, len(t)):

        top = S_1 - (2.0 * sigma_lv / (rho_l * R * T)) + (i * m * M / (4.0 / 3.0 * np.pi * (r[i - 1] ** 3) * rho_l * W))
        bottom = (L_lv * rho_l / (kappa * T)) * (L_lv * M / (R * T) - 1) + (rho_l * R * T) / (D_v * M * e_s)
        ratio = top / bottom

        r[i] = (ratio * t_delta / r[i - 1]) + r[i - 1]

    return r * 1.0E6


# estimates
t_start = 0.0
t_end = 50.0E3
t_delta = 1.0
t = np.arange(t_start, t_end, t_delta)

r14 = calculate_radius(1.0E-14 / 1.0E3, t)
r13 = calculate_radius(1.0E-13 / 1.0E3, t)
r12 = calculate_radius(1.0E-12 / 1.0E3, t)

# true values
r_true = np.asarray([1.0, 2.0, 4.0, 10.0, 20.0, 30.0, 50.0])  # radius [um]
t14_true = np.asarray([2.4, 130.0, 1.0E3, 2.7E3, 8.5E3, 17.5E3, 44.5E3])
t13_true = np.asarray([0.15, 7.0, 320.0, 1.8E3, 7.4E3, 16.0E3, 43.5E3])
t12_true = np.asarray([0.013, 0.61, 62.0, 870.0, 5.9E3, 14.5E3, 41.5E3])

plt.figure()
ax = plt.subplot(111)

ax.plot(t, r14, '-r')
ax.plot(t, r13, '-g')
ax.plot(t, r12, '-b')

ax.plot(t14_true, r_true, 'or')
ax.plot(t13_true, r_true, 'og')
ax.plot(t12_true, r_true, 'ob')

ax.set_xlabel('t [s]')
ax.set_ylabel(r'r [$\mu m$]')

ax.set_xlim([0.0, 50.0E3])
ax.set_ylim([0.0, 100.0])

plt.show()
