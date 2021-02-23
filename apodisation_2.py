import numpy as np
import scipy.special as sp
import matplotlib.pyplot as plt

x = np.linspace(0, 10, 1000)

v=1
ga=1
mu=1

a = (2*sp.jv(v, x*np.pi)/(x*np.pi) + 2*sp.jv(v, x*np.pi)/(x*np.pi))**2

plt.plot(x, a)
plt.legend(('Tache d Ariy; $\gamma = 1$ et $\eta = 1 $','apodi; $\gamma = 0.5$ et $\eta = 1$'), loc = 0)
plt.xlabel('$U$')
plt.ylabel('$log10(I(u)/I_0)$')
#plt.grid(True)
plt.tight_layout(0.3)
plt.show()

