# engagement-scripts
###### Dependencies: nmap, gobuster

###### env.sh - setup an environment and pre-define nmap scans (stolen from [@sullbrix](https://github.com/sullbrix/engagement-tools/blob/master/EH_Setup.sh))
###### gbc.sh - setup gobuster scans to launch multiple campaigns and observe the results

#### Setup
```bash
git clone https://github.com/dostoevskylabs/engagement-scripts.git && cd engagement-scripts
chmod +x env.sh
./env.sh
> YourProject
```

#### Phase 1
```bash
cd YourProject/Phase-1/
# Add targets (IP addresses or hostnames separated by newlines)
vi targets 
# Run your nmap campaign
./xxx-master.sh
# Viewing Results
grep --color -r --after-context 100 "Nmap scan report for" nmap-results
```

#### Phase 2
```bash
cd YourProject/Phase-2/
# Add domains (full URLs to the directory you wish to dirbust)
vi domains
# Run your gobuster campaign
./gbc.sh -w path/to/wordlist -t threadcount
# Viewing Results
grep -rw --color "(Status:" gobuster-results
```

