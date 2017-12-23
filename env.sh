#!/bin/bash
# slightly tweaked from @sullbrix (https://github.com/sullbrix/engagement-tools/blob/master/EH_Setup.sh)
echo
echo "What is the project name for the output files?"
read name

mkdir $name
mkdir $name/Phase-1
mkdir $name/Phase-2
mkdir $name/Phase-1/results
touch $name/Phase-1/nohup.out

echo "nmap -vv -sF -Pn -iL ../targets -oN results/nmap-F" > $name/Phase-1/xxx-nmapF
echo "nmap -vv -sn --open -iL ../targets -oN results/pingsNmap" > $name/Phase-1/xxx-nmapP
echo "nmap -vv -sT -Pn -p 1025-65535 -iL ../targets -oN results/nmap-T-full" > $name/Phase-1/xxx-nmapTfull
echo "nmap -vv -sT -Pn -p 1-1024 -iL ../targets -oN results/nmap-T-priv" > $name/Phase-1/xxx-nmapTpriv
echo "nmap -vv -sU -Pn -p 1-1024 -iL ../targets -oN results/nmap-U-priv" > $name/Phase-1/xxx-nmapUpriv

echo "./xxx-nmapP" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapF" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapTpriv" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapUpriv" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapTfull" >> $name/Phase-1/xxx-master.sh
echo "grep --color -r --after-context 10000 \"Nmap scan report for\" results" > $name/Phase-1/checkResults
chmod +x $name/Phase-1/checkResults
chmod +x $name/Phase-1/xxx-*

echo
echo "Script completed. Check all syntax and run ./xxx-master.sh to begin scans"
