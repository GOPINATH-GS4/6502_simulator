#!/bin/bash 
if [ $# -lt 3 ]; then 
	echo "Usage run \"Serial Port\" \"Assemby file\" \"OuputFile\" "
	exit 1
fi
if [ -f "$2" ]; then 
	$HOME/vasm/vasm6502_oldstyle -Fbin -dotdir $2 

	if [ $? -ne 0 ];then 
		echo "Compilation Failed .. Check output"
		exit 1
	else 
		dir=`dirname $3`
		file=`basename $3`
		if [ -d $dir ];then
			mv a.out $3
			python3 6502_rom_simulator.py $1 $3 

			else 
				echo "Output $dir directory does not exists"
				exit 1
		fi 
	fi 
	
		
else 
	echo "File $2 does not exist"
fi
