"""
Droplet growth rate.

Team MechE
SIO 217A

"""

import numpy as np
import matplotlib.pyplot as plt

from matplotlib import rcParams
params = {
    # text
    'font.size': 16,
    'xtick.labelsize': 14,
    'ytick.labelsize': 14,

    # lines
    'lines.linestyle': '-',
    'lines.linewidth': 1.0,
    'axes.color_cycle': 'k',
    'lines.markersize': 8,
    'lines.markeredgewidth': 1.0,

    # grid
    'grid.linestyle': ':',
    'grid.linewidth': 0.5,
    'grid.color': 'k',
    'grid.alpha': 0.3
}
rcParams.update(**params)


# Consider four scenarios:
#   1) no curvature or solute effects (Equation 5.27 in Curry and Webster)
#   2) curvature effects
#   3) saturation effects
#   4) both curvature and saturation effects
#
# NOTE: curvature and saturation effects should be neglible once the droplets
# grow beyond a few microns, but having data to back this up would be good
# (especially since the original source of Table 5.5., i.e., the Best 1951
# paper, includes both effects in their equation).
#

def droplet_radius(t, S_1=0.05, T=273.0, e_s=609.0):
    """
    Calculate droplet radius over time.

    Parameters
    ----------
    t : ndarray
        Time array.
    S_1 : float
        Supersaturation [%]
    T : float
        Ambient temperature [K]
    e_s : float
        Saturation pressure [mb].

    Returns
    -------
    r : ndarray
        Droplet radius.

    """

    # Constants
    R = 461.0  # vapor gas constant [J/(mol*K)]
    p = 900.0  # ambient pressure [hPa]
    rho_l = 1000.0  # density of water [kg/m^3]

    # Properties of water at T=273K
    kappa = 2.40E-2  # coefficient of thermal conductivity [J/(m*s*K)]
    D_v = 2.21E-5  # coefficient of vapor diffusivity [m^2/s]
    L_lv = 2.60E6  # latent heat [J/kg]
    sigma = 0.0761  # surface tension [N/m]

    # Parameters
    m_solt = 1.0E-15  # mass of solute (NaCl) [kg]
    M_solt = 58.44E-3  # molecular weight of solute (NaCl) [kg/mol]
    M_l = 18.0  # molecular weight of water [kg/mol]
    r0 = 0.75E-6  # initial radius of the droplet [m]
    S_1 = S_1 / 100.0  # supersaturation [-]

    K = (L_lv ** 2) * rho_l / (kappa * R * (T ** 2))
    D = rho_l * R * T / (e_s * D_v)

    r = np.sqrt((r0 ** 2) + (2 * S_1 / (K + D) * (t - t[0])))

    return r


t_start = 0.0
t_end = 45.0E3
t_delta = 1.0
t = np.arange(t_start, t_end, t_delta)
r = droplet_radius(t)

# Table 5.5 values
r_true = [1, 2, 4, 10, 20, 30, 50]
t_true14 = [2.4, 130, 1E3, 2.7E3, 8.5E3, 17.5E3, 44.5E3]
t_true13 = [0.15, 7.0, 320, 1.8E3, 7.4E3, 16.0E3, 43.5E3]
t_true12 = [0.013, 0.61, 62, 870, 5.9E3, 14.5E3, 41.5E3]

plt.figure()
ax = plt.subplot(111)

ax.plot(t, r * 1.0E6, ls='-', c='0.0')
ax.plot(t_true14, r_true, ls='', marker='o', markerfacecolor='0.3')
ax.plot(t_true13, r_true, ls='', marker='s', markerfacecolor='w', markeredgecolor='0.0')
ax.plot(t_true12, r_true, ls='', marker='^', markerfacecolor='0.3')

ax.set_xlabel('t [s]')
ax.set_ylabel(r'r [$\mu m$]')

ax.set_xticks([0.5E4, 1.5E4, 2.5E4, 3.5E4, 4.5E4])

# add legend above the plot and without a border
#ax.legend(loc='upper center', ncol=4, bbox_to_anchor=(0.5, 1.0), frameon=False)

ax.grid()

ax.set_ylim([0.0, 55.0])

plt.savefig('r_t.pdf')
#plt.show()
