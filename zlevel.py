#!/usr/bin/env python

import numpy as np
zval=np.array([0, 0, 0, 1, 1, 2, 2])
c1=0
indices=[]
for k in range(c1,len(zval)):
    print "{}{}".format('len(zval)= ',len(zval))
    print "{}{}".format('k= ',k)
    for j in range(k+1,len(zval)):
        if zval[k] == zval[j]:
            lind=len(indices)
            indices[(1+lind):]=[j]
    print "{}{}".format('indices= ',indices)
    zval=np.delete(zval,indices)
    print zval
    c1+=1
    indices=[]

