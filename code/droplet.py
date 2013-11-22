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

def droplet_radius(t, S_1=0.05, T=273.0, e_s=609.0, kappa=2.40E-2, D_v=2.21E-5, L_lv=2.5E6):
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
        Saturation pressure [mb]
    kappa : float
        Coefficient of thermal conductivity [J/(m*s*K)]
    D_v : float
        Coefficient of diffusivity at p=1000 mb [m^2/s]
    L_lv : float
        Latent heat of water [J/kg]

    Returns
    -------
    r : ndarray
        Droplet radius [um]

    """

    # Constants
    R = 461.0  # vapor gas constant [J/(mol*K)]
    p = 900.0  # ambient pressure [hPa]
    rho_l = 1000.0  # density of water [kg/m^3]

    # Parameters
    r0 = 0.75E-6  # initial radius of the droplet [m]
    S_1 = S_1 / 100.0  # supersaturation [-]
    D_v = D_v * (1.0E3 / p)  # adjust D_v

    K = (L_lv ** 2) * rho_l / (kappa * R * (T ** 2))
    D = rho_l * R * T / (e_s * D_v)

    r = np.sqrt((r0 ** 2) + (2 * S_1 / (K + D) * (t - t[0])))

    # return radius in microns
    return (r * 1.0E6)


def plot_table(t):
    """
    Plot model against Table 5.5 values.

    Parameters
    ----------
    t : ndarray
        Time array.

    """
    r = droplet_radius(t, T=273.0, e_s=0.6E3)

    # Table 5.5 values
    r_true = [1, 2, 4, 10, 20, 30, 50]
    t_true14 = [2.4, 130, 1E3, 2.7E3, 8.5E3, 17.5E3, 44.5E3]
    t_true13 = [0.15, 7.0, 320, 1.8E3, 7.4E3, 16.0E3, 43.5E3]
    t_true12 = [0.013, 0.61, 62, 870, 5.9E3, 14.5E3, 41.5E3]

    plt.figure()
    ax = plt.subplot(111)

    ax.plot(t, r, ls='-', c='0.0')
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


def plot_temperature(t):
    """Plot r(t) for multiple temperatures."""

    # r(t) with varying T
    # NOTE: keep L_lv constant (for now)
    r_273 = droplet_radius(t, T=273.0, e_s=6.15E2, kappa=2.40E-2, D_v=2.21E-6)
    r_283 = droplet_radius(t, T=283.0, e_s=12.3E2, kappa=2.48E-2, D_v=2.36E-5)
    r_293 = droplet_radius(t, T=293.0, e_s=23.4E2, kappa=2.55E-2, D_v=2.52E-5)
    r_303 = droplet_radius(t, T=303.0, e_s=42.4E2, kappa=2.63E-2, D_v=2.69E-5)

    plt.figure()
    ax = plt.subplot(111)

    ax.plot(t, r_273, ls='-', c='0.0')
    ax.plot(t, r_283, ls=':',lw=1.5, c='0.0')
    ax.plot(t, r_293, ls='-', c='0.5')
    ax.plot(t, r_303, ls='--', c='0.5')

    ax.set_xlabel('t [s]')
    ax.set_ylabel(r'r [$\mu m$]')

    ax.set_xticks([0.5E4, 1.5E4, 2.5E4, 3.5E4, 4.5E4])

    ax.grid()

    ax.set_ylim([0.0, 90.0])

    plt.savefig('r_t_temperature.pdf')
    #plt.show()

if __name__ == '__main__':

    t_start = 0.0
    t_end = 45.0E3
    t_delta = 1.0
    t = np.arange(t_start, t_end, t_delta)

    # plot r(t) of model vs Table 5.5
    #plot_table(t)

    # plot r(t) as temperature is varied
    #plot_temperature(t)
