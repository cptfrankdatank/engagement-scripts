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

mkdir $name
mkdir $name/results
mkdir $name/results/nmap
mkdir $name/results/dirfuzz
cp tools/parse-nmap.sh $name/results/parse-nmap.sh
cp tools/parse-dirfuzz.sh $name/results/parse-dirfuzz.sh
chmod +x $name/results/*.sh

mkdir $name/Phase-1
mkdir $name/Phase-2
cp tools/dirfuzz.sh $name/Phase-2/dirfuzz.sh
chmod +x $name/Phase-2/*.sh
touch $name/Phase-1/targets
touch $name/Phase-2/domains

echo "nmap -vv -sF -iL targets -Pn --append-output -oG ../results/nmap/nmapF" > $name/Phase-1/xxx-nmapF
echo "nmap -vv -sn -iL targets --open --append-output -oG ../results/nmap/nmapP" > $name/Phase-1/xxx-nmapP
echo "nmap -vv -sT -iL targets -Pn -p 1025-65535 --append-output -oG ../results/nmap/nmapTfull" > $name/Phase-1/xxx-nmapTfull
echo "nmap -vv -sT -iL targets -Pn -p 1-1024 --append-output -oG ../results/nmap/nmapTpriv" > $name/Phase-1/xxx-nmapTpriv
echo "nmap -vv -sU -iL targets -Pn -p 1-1024 --append-output -oG ../results/nmap/nmapUpriv" > $name/Phase-1/xxx-nmapUpriv

echo "./xxx-nmapP" > $name/Phase-1/xxx-master.sh
echo "./xxx-nmapF" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapTpriv" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapUpriv" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapTfull" >> $name/Phase-1/xxx-master.sh
chmod +x $name/Phase-1/xxx-*
