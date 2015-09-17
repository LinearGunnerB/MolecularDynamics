#!/bin/bash
#starts using sed on 3rd line, looking to put 79 at the beginning of every line
#label 79 for VMD to recognize them as Gold atoms
#Do not type -n , it silents the output and won't show up in vmdViewNW.xyz
# 3,$ means from line 3 to the end of the file

# the | sed 's/# //' removes the #'s that python puts on the output file
sed '3,$s/^/79 /' NanoWireZ.xyz | sed 's/# //' > vmdViewNW001.xyz

# if we are testing Zcyl
#sed '3,$s/^/79 /' Zcyl.xyz | sed 's/# //' > vmdZcyl.xyz
echo "Output to vmdViewNW.xyz"

#repeat for NW011
sed '3,$s/^/79 /' NanoWire011.xyz | sed 's/# //' > vmdViewNW011.xyz
