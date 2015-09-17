#!/bin/bash
# include input to 1) search for 2) input file
echo "Continue Y/n: "
read YesNo 
if [ "$YesNo" == "Y"  ] || [ "$YesNo" == "y" ]; then

	#first check if the dump directory exists
	if [ -d dump ]; then
		#Chekc if the dump folder is empty
		if [ "$(ls -A dump)" ]; then
			echo "dump is not empty"
			cd dump
			rm *
			cd ../
			rmdir dump
			echo "Removed dump and its contents"
		else # empty so delete it
			echo "dump is empty, deleting it"
			rmdir dump
		fi
		
	else
		echo "Good, no dump directory, continue"
	fi	
	
	#Check if the file2cat files actually exists, if not then exit
	#if we didn't rm dump above it would show up here
	if [ $(ls | grep "dump" | wc -w) -gt 0 ]; 
		then echo "lammps dump.xyz files exist, continuing"
	else
		echo "You didn't run lammps yet **Quit and run LAMMPS**"
		exit
	fi

	echo "Starting script"
	echo "Name of dump files before the padded numbers:"
	#read fileinput, meant to be lammps dumpfilename, often named dump.xzy
	read file2cat
	cat "$file2cat".0*.xyz > TotalDump.xyz 	
	echo "Created TotalDump.xyz"

        #We also care about date at certain TimeStep to pass to python
	echo "Favorite Time Step: "
	read TimeStep
	#Use double quotes "" so sed expands varibles
	sed -e "1,/Atoms. Timestep: $TimeStep/d" "$file2cat".*"$TimeStep".xyz > temp.xyz

	#extracts columns 2,3,4 and not 1. Needs -d " " to indicate a space is
	# what's separating each column. And pass the output to a different
	# file_name, otherwise results.xyz will be blank
	cut -f 2,3,4 -d " " temp.xyz > pydump.xyz
	echo "Favorite TimeStep exported to pydata.xyz"	
	
	# make new dump directory and move the indididual dumps there
	mkdir dump
	mv "$file2cat".0*.xyz dump
	echo "moved dump files to dump directory"
	
	#create datafile from pydump file by adding numbers 1 to Total#atoms, still need to modify datafile manually to add other info
##	nl temp.xyz > datafile.txt	

	# delete temp.xyz
	rm temp.xyz
	
	#end of modifications
	echo "Dump Mods Complete :D Hurrah!"
fi

#THE END
echo "End of script"
 


