#appel des Libs
import numpy as np
import scipy.special as sp
import matplotlib.pyplot as plt

x = np.linspace(0, 10, 1000)
#l'ordre du fonction de bessel card
v=1
#U max
um=1.5
#l'intensite totale
a = (2*sp.jv(v, x*np.pi)/(x*np.pi) + 2*sp.jv(v, x*np.pi)/(x*np.pi))**2
#visialisation du Fig
plt.plot(x, a)
plt.legend(('Tache d Ariy; $\gamma = 1$ et $\eta = 1 $','apodi; $\gamma = 0.5$ et $\eta = 1$'), loc = 0)
plt.xlabel('$U$')
plt.ylabel('$log10(I(u)/I_0)$')
#plt.grid(True)
plt.tight_layout(0.3)
plt.savefig("hhhhhhhhh.png")
plt.show()



#khasni db kifach nhsab hadik l'intebsite li dayza fdisc??? hhhhhhhhhhhhhh
