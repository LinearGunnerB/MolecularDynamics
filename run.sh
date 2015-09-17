#!/bin/bash
rm dump.0*.xyz
echo "Running lmp_serial.exe < in.Au.lattice.txt"
lmp_serial < in.latticeAu.txt
cat dump.0*.xyz > total_lattice.xyz
echo "Running xyz2py.sh"
./xyz2py.sh
echo "Running py2NW.py"
python py2NW.py
echo "Running atomicNumber.sh, it makes python output viewable by VMD"
./atomicNumber.sh
# Check we have a nice NW, vmd vmdViewNW.xyz = TRUE
# Convert .xyz files to datafiles to be read by next couple input scripts
# make the 2nd convert fail
rm minnw2data.txt
echo "Converting vmdViewNW.xyz to data2min.txt "
./nw2data.sh
# minimize energy of NW with in.minNW.txt, use read_data
echo "Running in.minNW.txt to minimize energy of NW"
lmp_serial < in.minNW001.txt
#####
#echo "Manually: dump.finaltime.xyz > minnw2data.txt"
####
echo "Pick out dump.#.xyz with lowest p_energy"
echo "Final Time Step= "
read Finalstep
cat dump.0*"$Finalstep".xyz > minnw2data001.xyz
rm dump.0*.xyz
#######
##Repeating for NW<011>
echo "Running in.minNW.txt to minimize energy of NW <011>"
lmp_serial < in.minNW011.txt
echo "Pick out dump.#.xyz with lowest p_energy for <011>"
echo "Final Time Step= "
read Finalstep
cat dump.0*"$Finalstep".xyz > minnw2data011.xyz
rm dump.0*.xyz
# Do 2nd conversion to datafile
echo "Converting minimized NW to datafile"
./nw2data.sh
# use read_data to read in datafile of minimized NW
echo "Running compression on minimized NW"
lmp_serial < in.nwcompress001.txt
# make a movie
# rm totaldump.xyz  # removing old xyz
cat dump.0*.xyz > temp.xyz
########################
##Need this step or VMD will think we are using Hydrogen not Gold
sed '3,$s/1 /79 /' temp.xyz > total_min_compress001.xyz
rm temp.xyz
#####################
# testing result without minimizing the NW. in.nwcompress2.txt reads data2min.txt instead of compressMeData.txt
rm dump.0*.xyz #remove old dumps before new simulation 
echo "Running compression on unminimized NW for comparison"
lmp_serial < in.nwcompress011.txt
cat dump.0*.xyz > temp.xyz
sed '3,$s/1 /79 /' temp.xyz > total_min_compress011.xyz
rm temp.xyz
rm dump.0*.xyz

#run ./pyplot.py
