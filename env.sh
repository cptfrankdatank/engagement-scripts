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
mkdir $name/results/dirsearch
mkdir $name/results/dirfuzz
mkdir $name/results/data-exfil

cp tools/parse-nmap.sh $name/results/parse-nmap.sh
cp tools/parse-dirfuzz.sh $name/results/parse-dirfuzz.sh
chmod +x $name/results/*.sh

mkdir $name/Phase-1
mkdir $name/Phase-1/nmap
mkdir $name/Phase-1/dirbust
cp tools/dirfuzz.sh $name/Phase-1/dirbust/dirfuzz.sh
cp tools/dirsearch.sh $name/Phase-1/dirbust/dirsearch.sh
chmod +x $name/Phase-1/dirbust/*.sh

mkdir $name/Phase-2
mkdir $name/Phase-2/exploits
mkdir $name/Phase-2/http-reqres
cp tools/linuxfiles.txt $name/Phase-2/linuxfiles.txt

mkdir $name/Phase-3

mkdir $name/Phase-3/shells
cp tools/tcpReverseShell.py $name/Phase-3/shells/tcpReverseShell.py
cp tools/udpReverseShell.py $name/Phase-3/shells/udpReverseShell.py
echo "socat file:\`tty\`,echo=0,raw udp-listen:443" > $name/Phase-3/socatListener.sh
echo "python -m SimpleHTTPServer" > $name/Phase-3/httpServer.sh
chmod +x $name/Phase-3/*.sh

mkdir $name/Phase-3/privesc
cp tools/setuid.c  $name/Phase-3/privesc/setuid.c
cp tools/linuxprivchecker.py $name/Phase-3/privesc/linuxprivchecker.py

touch $name/Phase-1/nmap/targets
touch $name/Phase-1/dirbust/domains

echo "nmap -vv -n --open --reason -PS21,22,23,25,135,139,445,3389,1433,80,443,8080,8443,90,3268,110,53,3306,1723,111,995,993,5900,1025,1720,465,548,5060,8000,515,2049,6000,389,5432 -iL targets --append-output -oG ../../results/nmap/nmapCommPorts" > $name/Phase-1/nmap/xxx-nmapCommPorts
echo "nmap -vv -sT --open --reason -R -T4 --max-retries 3 --min-rate 120 --max-rtt-timeout 300ms -Pn -p 1025-65535 -iL targets --append-output -oG ../../results/nmap/nmapTfull" > $name/Phase-1/nmap/xxx-nmapTfull
echo "nmap -vv -sT --open --reason -R -T4 --max-retries 3 --min-rate 120 --max-rtt-timeout 300ms -Pn -p 1-1024 -iL targets --append-output -oG ../../results/nmap/nmapTpriv" > $name/Phase-1/nmap/xxx-nmapTpriv
echo "nmap -vv -sU --open --reason -R -T4 --max-retries 3 --min-rate 120 --max-rtt-timeout 300ms -Pn -p 1-1024 -iL targets --append-output -oG ../../results/nmap/nmapUpriv" > $name/Phase-1/nmap/xxx-nmapUpriv

echo "./xxx-nmapCommPorts" > $name/Phase-1/nmap/xxx-master.sh
echo "./xxx-nmapTpriv" >> $name/Phase-1/nmap/xxx-master.sh
echo "./xxx-nmapUpriv" >> $name/Phase-1/nmap/xxx-master.sh
echo "./xxx-nmapTfull" >> $name/Phase-1/nmap/xxx-master.sh
chmod +x $name/Phase-1/nmap/xxx-*
