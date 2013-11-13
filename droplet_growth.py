"""
Cloud droplet growth.

David Larson
dplarson@ucsd.edu

"""

import numpy as np
import matplotlib.pyplot as plt

# constants
S_1 = 0.05 / 100.0  # [%]
T = 273.0           # ambient temperature [K]
p = 900.0           # ambient pressure [mb]
R_v = 461.0         # gas constant [
rho_l = 1000.0      # water density [kg/m^3]

# constants at T = 273 K
L_lv = 2.25E6                     # latent heat [J/
e_s = 12.3 / 2.0                  # saturation pressure [mb]
kappa = 2.40E-2                   #
D_v = 2.21E-5 * 1000.0 / p  #

# nucleus of NaCl (salt)
rho_salt = 2160.0        # [kg/m^3]
m_salt = 1.0E-14 / 1E3   # [kg]
r0 = np.sqrt(3 * m_salt / (4 * np.pi * rho_salt))
#r0 = 0.75E-6

delta_t = 1.0
t_min = 0.0
t_max = 44.5E3
t0 = np.arange(t_min, t_max, delta_t)
t = t0 + delta_t
r = np.zeros(len(t))

K = (L_lv ** 2) * rho_l / (kappa * R_v * (T ** 2))
D = rho_l * R_v * T / (e_s * D_v)

for i in range(len(t)):
    r[i] = np.sqrt((r0 ** 2) + 2 * S_1 / (K + D) * (t[i] - t0[i]))
    r0 = r[i]

# true values
t_true = np.asarray([2.4, 130.0, 1.0E3, 2.7E3, 8.5E3, 17.5E3, 44.5E3])
r_true = np.asarray([1.0, 2.0, 4.0, 10.0, 20.0, 30.0, 50.0]) * 1.0E-6


plt.figure()
ax = plt.subplot(111)
ax.plot(t, r * 1.0E6, '--r')
ax.plot(t_true, r_true * 1.0E6, '-ok')
ax.set_xlabel('t [s]')
ax.set_ylabel('r [um]')

ax.set_ylim([0.0, 50.0])
plt.show()
