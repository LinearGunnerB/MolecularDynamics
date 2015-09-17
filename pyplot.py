#!/usr/bin/env python

import numpy as np
import pylab as pl
#load each NW and plot all three curves together
#what about the energy of each NW?
print "***** Change the tim_of_loop value *****"
#time_of_loop_in_inputfile=2000
time_of_loop_in_inputfile=2000
# 1st NW
#a=np.loadtxt('outputforce.txt')
a=np.loadtxt('forcenw001r5.txt')
a1=np.loadtxt('forcenw001r10.txt')
a2=np.loadtxt('forcenw001r15.txt')
#a3=np.loadtxt('forcenw001r25.txt')

b=[]
for k in range(len(a)):
    #if the time is a multiple of 2000 grab it
    if a[k,0]%time_of_loop_in_inputfile == 0 :
        b.append(a[k,:])
B=np.array(b)
print B
del b
#same radius set in py2NW.py
r=5.0
area=np.pi*r**2
#calculate stress
stress=B[:,1]/(np.pi*r**2)
#calculate strain, first declare eprate as in in.nwcompress.txt per 2000 steps or however many Angtroms per #picoseconds
eprate=abs(-0.1)
deltaL=eprate/time_of_loop_in_inputfile
L=160
strain=B[:,0]*deltaL/L
#plot1
plot1=pl.plot(strain,stress,'-o',label='r5')

# 2nd NW
b1=[]
for k in range(len(a1)):
    #if the time is a multiple of 2000 grab it
    if a1[k,0]%time_of_loop_in_inputfile == 0 :
        b1.append(a1[k,:])
B=np.array(b1)
del b1
#same radius set in py2NW.py
r=10.0
area=np.pi*r**2
#calculate stress
stress=B[:,1]/(np.pi*r**2)
#calculate strain, first declare eprate as in in.nwcompress.txt per 2000 steps or however many Angtroms per #picoseconds
eprate=abs(-0.1)
deltaL=eprate/time_of_loop_in_inputfile
L=160
strain=B[:,0]*deltaL/L
#plot2
plot2=pl.plot(strain,stress,'-o', label='r10')

# 3rd NW
b2=[]
for k in range(len(a2)):
    #if the time is a multiple of 2000 grab it
    if a2[k,0]%time_of_loop_in_inputfile == 0 :
        b2.append(a2[k,:])
B=np.array(b2)
del b2
#same radius set in py2NW.py
r=15.0
area=np.pi*r**2
#calculate stress
stress=B[:,1]/(np.pi*r**2)
#calculate strain, first declare eprate as in in.nwcompress.txt per 2000 steps or however many Angtroms per #picoseconds
eprate=abs(-0.1)
deltaL=eprate/time_of_loop_in_inputfile
L=160
strain=B[:,0]*deltaL/L
#plot3
plot3=pl.plot(strain,stress,'-o', label='r15')

# Bulk Gold plot  or mention its youngs modulous
plot4=pl.plot([0,0.0035],[0,0.000600595],'-o',label='bulk')


# Finally
pl.xlabel('strain (Unitless)')
pl.ylabel('stress (eV/Angstrom^3)')
pl.title('Au NW stress vs strain')
#pl.legend([plot1,plot2],('r5','r10'),'best',numpoints=1  )
pl.legend(loc='best')
pl.show()

#e1=(stress[1]-stress[0])/(strain[1]-strain[0])
#e4=(stress[4]-stress[1])/(strain[4]-strain[1])
#e6=(stress[6]-stress[4])/(strain[6]-strain[4])
#print e1
#print e4
#print e6
