#!/bin/bash
# slightly tweaked from @sullbrix (https://github.com/sullbrix/engagement-tools/blob/master/EH_Setup.sh)
echo ""
echo "What is the project name for the output files?"
read name
echo ""

if [ -d "$name" ]; then
  echo "Project exists, choose a different name"
  exit
fi

if [ ! -f "targets" ]; then
  echo "You must create a targets file"
  exit
fi

mkdir $name
mkdir $name/results
mkdir $name/results/nmap
cp tools/parse-nmap.sh $name/results/parse-nmap.sh
chmod +x $name/results/*.sh

for target in $(cat targets); do
	if [ ! -d "$name/$target" ]; then
		mkdir $name/$target
		mkdir $name/$target/Phase-1
		mkdir $name/$target/Phase-2
    cp tools/dirfuzz.sh $name/$target/Phase-2/dirfuzz.sh
    chmod +x $name/$target/Phase-2/*.sh
	fi

	echo "nmap -vv -sF -Pn --append-output -oG ../../results/nmap/$target $target" > $name/$target/Phase-1/xxx-nmapF
	echo "nmap -vv -sn --open --append-output -oG ../../results/nmap/$target $target" > $name/$target/Phase-1/xxx-nmapP
	echo "nmap -vv -sT -Pn -p 1025-65535 --append-output -oG ../../results/nmap/$target $target" > $name/$target/Phase-1/xxx-nmapTfull
	echo "nmap -vv -sT -Pn -p 1-1024 --append-output -oG ../../results/nmap/$target $target" > $name/$target/Phase-1/xxx-nmapTpriv
	echo "nmap -vv -sU -Pn -p 1-1024 --append-output -oG ../../results/nmap/$target $target" > $name/$target/Phase-2/xxx-nmapUpriv

	echo "./xxx-nmapP" > $name/$target/Phase-1/xxx-master.sh
	echo "./xxx-nmapF" >> $name/$target/Phase-1/xxx-master.sh
	echo "./xxx-nmapTpriv" >> $name/$target/Phase-1/xxx-master.sh
	echo "./xxx-nmapUpriv" >> $name/$target/Phase-1/xxx-master.sh
	echo "./xxx-nmapTfull" >> $name/$target/Phase-1/xxx-master.sh
	chmod +x $name/$target/Phase-1/xxx-*
done
