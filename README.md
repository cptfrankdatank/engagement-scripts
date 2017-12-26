# engagement-scripts
###### Dependencies: nmap, gobuster

###### env.sh - setup an environment and pre-define nmap scans (stolen from [@sullbrix](https://github.com/sullbrix/engagement-tools/blob/master/EH_Setup.sh))
###### gbc.sh - setup gobuster scans to launch multiple campaigns and observe the results

#### TODO
1.  Currently there are a lot of limitations as it is in proof of concept stages. For example you can't call scripts outside of the directory they are in as there are hardcoded file paths being used. This is a stupid limitation that I'm too lazy to sort out currently.
2.  The parsing scripts will become more modular to parse out different pieces of data as well as sorting by clauses.
3.  General bad practice - theres a lot of cleanup to do that I'll slowly get around to currently I am still trying to figure out the best way to do the things we are already doing, but my general idea is this:
```
-> run init script
  -> name project
  -> define scope
    -> builds dir structure for your environment
  -> Phase-1
    -> uses the scope provided, additionally you can add more hostnames to increase your scope here
    -> Generates nmap scans to run in Phase-1
      -> Results save in a unified manner in ProjectName/results/nmap/hostname
  -> Phase-2
    -> define domains
    -> Generates gobuster campaigns to run in Phase-2
      -> Results save in a unified manner in ProjectName/results/dirfuzz/webaddress/wordlist
  -> Parse Results
    -> Ability to get an overview of all findings
    -> Fine tune by sorting options
    -> Fine tune by selecting only X IP address, or X web address, etc
```

#### Setup
```bash
git clone https://github.com/dostoevskylabs/engagement-scripts.git && cd engagement-scripts
chmod +x env.sh
# Add targets (IP addresses or hostnames separated by newlines)
vi targets
# init your environment
./env.sh
> YourProject
```

#### Phase 1
```bash
cd YourProject/$target/Phase-1/
# Run your nmap campaign
./xxx-master.sh
# Viewing Results
cd YourProject/results && ./parse-nmap.sh
```

#### Phase 2
```bash
cd YourProject/$target/Phase-2/
# Add domains (full URLs to the directory you wish to dirbust)
vi domains
# Run your dirfuzz campaign
./dirfuzz.sh -w path/to/wordlist -t threadcount
# Viewing Results
cd YourProject/results && ./parse-dirfuzz.sh
```

