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
mkdir $name/Phase-1
mkdir $name/Phase-1/nmap-results
touch $name/Phase-1/targets
mkdir $name/Phase-2
mkdir $name/Phase-2/gobuster-results
touch $name/Phase-2/domains

curl -o $name/Phase-2/gbc.sh https://raw.githubusercontent.com/dostoevskylabs/engagement-scripts/master/tools/gbc.sh 2>/dev/null
chmod +x $name/Phase-2/gbc.sh

echo "nmap -vv -sF -Pn -iL targets -oN nmap-results/nmap-F" > $name/Phase-1/xxx-nmapF
echo "nmap -vv -sn --open -iL targets -oN nmap-results/pingsNmap" > $name/Phase-1/xxx-nmapP
echo "nmap -vv -sT -Pn -p 1025-65535 -iL targets -oN nmap-results/nmap-T-full" > $name/Phase-1/xxx-nmapTfull
echo "nmap -vv -sT -Pn -p 1-1024 -iL targets -oN nmap-results/nmap-T-priv" > $name/Phase-1/xxx-nmapTpriv
echo "nmap -vv -sU -Pn -p 1-1024 -iL targets -oN nmap-results/nmap-U-priv" > $name/Phase-1/xxx-nmapUpriv

echo "./xxx-nmapP" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapF" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapTpriv" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapUpriv" >> $name/Phase-1/xxx-master.sh
echo "./xxx-nmapTfull" >> $name/Phase-1/xxx-master.sh
chmod +x $name/Phase-1/xxx-*

echo
echo "Environment created for $name"
echo "Begin Phase-1 by adding targets and running $name/Phase-1/xxx-master.sh"
echo "Begin Phase-2 by adding domains and running $name/Phase-2/gbc.sh"
