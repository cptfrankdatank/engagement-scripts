#!/bin/bash
# slightly tweaked from @sullbrix (https://github.com/sullbrix/engagement-tools/blob/master/EH_Setup.sh)
echo ""
echo "What is the project name for the output files?"
read name

if [ -d "$name" ]; then
  "Project exists, choose a different name"
  exit
fi

mkdir $name
mkdir $name/Phase-1
mkdir $name/Phase-1/nmap-results
mkdir $name/Phase-2

curl -o $name/Phase-2/gbc.sh https://raw.githubusercontent.com/dostoevskylabs/engagement-scripts/master/gbc.sh 2>/dev/null
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
echo "grep --color -r --after-context 10000 \"Nmap scan report for\" nmap-results" > $name/Phase-1/checkResults
chmod +x $name/Phase-1/checkResults
chmod +x $name/Phase-1/xxx-*

echo
echo "Script completed."
echo "Begin Phase-1 by adding targets and running $name/Phase-1/xxx-master.sh"
echo "Begin Phase-2 by adding domains and running $name/Phase-2/gbc.sh"
