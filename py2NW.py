#!/usr/bin/env python
import numpy as np
# length = size(A)/3    # 3 directions x,y,z, also could use len(A) to get 64000
# rearrange atoms z-coordinate from lowest to highest
#A=np.sort(A,axis=0)
#print A
A = np.loadtxt('pydump.xyz')
Alength = len(A)
x = A[0:Alength,0]    # first column of data
y = A[0:Alength,1]    # Second column of data
z = A[0:Alength,2]    # third column of data
#Reshape with x=x.reshape(length,1)
x=x.reshape(Alength,1)
y=y.reshape(Alength,1)
z=z.reshape(Alength,1) 
#Set Radius of NW r
r = 10   #style metal is in Angostroms
############## Nanowire  <001>  ################
indices2remove=[]
for k in range(Alength):
    if (x[k]-30)**2 + (y[k]-30)**2 > r**2:
        #remove those elements 
        #storing indices to an array
        lind2rm=len(indices2remove)
        indices2remove[(1+lind2rm):]=[k]
#end of for loop
# print indices2remove
#removing indices from x,y,z
xout = np.delete(x,indices2remove)
yout = np.delete(y,indices2remove)
zout = np.delete(z,indices2remove)
#maybe reshape x,y,z
lengthout=len(xout)
#Check they are all the same size
#print len(xout) 
#print len(yout) 
#print len(zout), they were the same size
xout=xout.reshape(lengthout,1)
yout=yout.reshape(lengthout,1)
zout=zout.reshape(lengthout,1)
#To convert a list into an array: np.asarray(a)
#Tp print entire array use: set_printoptions(threshold=nan)
#Finally print new data to file
#Au is element 79 add column for VMD to read as gold
Zcyl = np.hstack((xout,yout,zout))  #combinging arrays horizontally, vertically use np.vstack

# I used this line to compare NW in VMD before and after, helped debug slicing
# np.savetxt('Zcyl.xyz',Zcyl,fmt='%3.3f',header=str(len(Zcyl))+'\nAtoms. Timestep: 01')

# rearrange data from lowest to highest z-coordinate
# two ways to do accomplish, b/c i.e. temp=Zcyl[j,:], Zcyl[k,:]=temp won't work
for k in range(len(xout)):
    for j in range(k+1,len(xout)):
        if Zcyl[k,2] > Zcyl[j,2]:
            # method 1: Basic slicing
            temp=np.copy(Zcyl[j,:])
            Zcyl[j,:]=Zcyl[k,:]
            Zcyl[k,:]=temp
            # method 2: Advanced slicing
#            Zcyl[[k,j],:] = Zcyl[[j,k],:]

print "Rearranged Zcyl before saving to file :-) COMPLETE"
# print Zcyl

#f = open('test.txt','w') #w or r+
#3.3f is 3 decimal places before and after of a floating point number
np.savetxt('NanoWireZ.xyz', Zcyl, fmt='%3.3f', header=str(len(Zcyl))+'\nAtoms. Timestep: 01') 
print "Output to NanoWireZ.xyz"


# Going 
# To 2nd
# Nano Wire!!!
print "Loading 2nd NanoWire"
######### Nanowire  <111>  ############
# define function to move incriment accurately
def drange2(start, stop, step):
    numelements = int((stop-start)/float(step))
    for i in range(numelements+1):
            yield start + i*step
#arrange in order of Z
for k in range(len(xout)):
    for j in range(k+1,len(xout)):
        if A[k,2] > A[j,2]:
            # method 1: Basic slicing
            temp=np.copy(A[j,:])
            A[j,:]=A[k,:]
            A[k,:]=temp

print  "track z-values with NO REPEATS"
indices2remove=[]
zval=[r for r in A[:,2] ]  # makes 1D list of zvalues from A
#print zval
c=0
for k in range(c,len(zval)):
    for j in range(k+1,len(zval)):
        if zval[k] == zval[j]:
            lindex=len(indices2remove)
            indices2remove[(1+lindex):]=[j]
    zval=np.delete(zval,indices2remove)            
    c+=1
    indices2remove=[]
print zval
# end of tracking zvalues
#for t in range():
for lava in zval:
    for k in range(Alength):
        for t in drange2(11,57,161.0/57):	
            if z[k] == lava:
                if (x[k]-t)**2 + (y[k]-t)**2 > r**2:
                    #remove those elements 
                    #storing indices to an array
                    lind2rm=len(indices2remove)
                    indices2remove[(1+lind2rm):]=[k]

#print indices2remove
#removing indices from x,y,z
xout = np.delete(x,indices2remove)
yout = np.delete(y,indices2remove)
zout = np.delete(z,indices2remove)
#maybe reshape x,y,z
lengthout=len(xout)
xout=xout.reshape(lengthout,1)
yout=yout.reshape(lengthout,1)
zout=zout.reshape(lengthout,1)
Zcyl = np.hstack((xout,yout,zout))  #combinging arrays horizontally, vertically use np.vstack
np.savetxt('NanoWire011.xyz', Zcyl, fmt='%3.3f', header=str(len(Zcyl))+'\nAtoms. Timestep: 01')
print "------->>Saved to NanoWire011.xyz <<-------" 
