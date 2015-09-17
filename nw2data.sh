#!/bin/bash
echo "Change xlo xhi, # atoms, Mass,  etc. of nw2data.sh for specific case"
FILE="data2min001.txt"
# lammps manual says any atom type can be used but >1 takes more memory.
/bin/cat <<EOM >$FILE
# Header: datafile to pass to in.minNW001.txt
3080 atoms

1 atom types

0.0000 80.0000 xlo xhi
0.0000 80.0000 ylo yhi
0.0000 300.0000 zlo zhi

Masses

1 196.96657

Atoms

EOM
# remove 79 and replace with a 1
sed '3,$s/79/1 /' vmdViewNW001.xyz > temp.xyz
# tail -n specifies #lines to show. Combined with +3 shows from line 3 to end 
tail -n +3 temp.xyz | nl -nln >> data2min001.txt
# nl numbers each line, the [option=nl] means left justified
echo "Output ---> data2min001.txt"
rm temp.xyz
#######################
###repeat for NW<011>
#####################
FILE="data2min011.txt"
# lammps manual says any atom type can be used but >1 takes more memory.
/bin/cat <<EOM >$FILE
# Header: datafile to pass to in.minNW011.txt
3080 atoms

1 atom types

0.0000 80.0000 xlo xhi
0.0000 80.0000 ylo yhi
0.0000 300.0000 zlo zhi

Masses

1 196.96657

Atoms

EOM
# remove 79 and replace with a 1
sed '3,$s/79/1 /' vmdViewNW011.xyz > temp.xyz
# tail -n specifies #lines to show. Combined with +3 shows from line 3 to end 
tail -n +3 temp.xyz | nl -nln >> data2min011.txt
# nl numbers each line, the [option=nl] means left justified
echo "Output ---> data2min011.txt"
rm temp.xyz
#################
#echo "minnw2data.xyz is made manually from final dumpfile of in.minNW.txt"
##################
# if 2nd .xyz file exists then convert it to a datafile.txt
if [ $(ls | grep "minnw2data" | wc -w) -gt 0 ]; 
	then 	echo "Minimized NW.xyz exist, continuing"
		#echo "***READ************READ********READ*********"
		echo "Change xlo xhi, # atoms, Mass,  etc. of nw2data.sh for specific case"
		FILE="compressMeData001.txt"
		# lammps manual says any atom type can be used but >1 takes more memory.
/bin/cat <<EOM >$FILE
# Header: datafile to pass to in.nwcompress001.txt
3080 atoms

1 atom types

0.0000 80.0000 xlo xhi
0.0000 80.0000 ylo yhi
0.0000 300.0000 zlo zhi

Masses

1 196.96657

Atoms

EOM

FILE="compressMeData011.txt"
# lammps manual says any atom type can be used but >1 takes more memory.
/bin/cat <<EOM >$FILE
# Header: datafile to pass to in.nwcompress001.txt
3080 atoms

1 atom types

0.0000 80.0000 xlo xhi
0.0000 80.0000 ylo yhi
0.0000 300.0000 zlo zhi

Masses

1 196.96657

Atoms

EOM
# tail -n specifies #lines to show. Combined with +3 shows from line 3 to end 
tail -n +3 minnw2data001.xyz | nl -nln >> compressMeData001.txt
# nl numbers each line, the [option=nl] means left justified
echo "Output ---> compressMeData001.txt"
# rm temp.xyz
tail -n +3 minnw2data011.xyz | nl -nln >> compressMeData011.txt
# nl numbers each line, the [option=nl] means left justified
echo "Output ---> compressMeData011.txt"

 	
        else
                echo "You didn't minimize the NW yet **Quit and run LAMMPS**"
                exit
        fi


