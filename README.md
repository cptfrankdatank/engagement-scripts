# engagement-scripts
###### env.sh - setup an environment and pre-define nmap scans (stolen from @sullbrix)
###### gbc.sh - setup gobuster scans to launch multiple campaigns and observe the results

#### Setup
###### Dependencies: nmap, gobuster
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
```

#### Phase 2
```bash
cd YourProject/Phase-2/
# Add domains (full URLs to the directory you wish to dirbust)
vi domains
# Run your gobuster campaign
./gbc.sh -w path/to/wordlist -t threadcount
```

