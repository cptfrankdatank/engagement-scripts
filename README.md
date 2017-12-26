# engagement-scripts
###### Dependencies: nmap, gobuster

###### env.sh - setup an environment and pre-define nmap scans (stolen from [@sullbrix](https://github.com/sullbrix/engagement-tools/blob/master/EH_Setup.sh))
###### tools/dirfuzz.sh - setup gobuster scans to launch multiple campaigns and observe the results
###### tools/parse-nmap.sh - parse nmap results
###### tools/parse-dirfuzz.sh - parse dirfuzz results

#### TODO
1.  Currently there are a lot of limitations as it is in proof of concept stages. For example you can't call scripts outside of the directory they are in as there are hardcoded file paths being used. This is a stupid limitation that I'm too lazy to sort out currently.
2.  The parsing scripts will become more modular to parse out different pieces of data as well as sorting by clauses.
3.  General bad practice - theres a lot of cleanup to do that I'll slowly get around to currently I am still trying to figure out the best way to do the things we are already doing, but my general idea is this:
```
-> run init script
  -> name project
    -> builds dir structure for your environment
    -> copies scripts from tools/ to the phase directories
    -> generates nmap scans that are copied to phase-1
  -> Phase-1
    -> define scope by adding ip/hostname(s) separated by a newline to the targets file
    -> run nmap scans by executing ./xxx-master.sh
      -> Results save in a unified manner in ProjectName/results/nmap/scantype
      -> run ./parse-nmap.sh to view results
  -> Phase-2
    -> define domains by adding url(s) separated by a newline to the domains file
    -> generates gobuster campaigns for each domain supplied
      -> Results save in a unified manner in ProjectName/results/dirfuzz/webaddress/wordlist
      -> run ./parse-dirfuzz.sh to view results
  -> Parsing Results
    -> Ability to get an overview of all findings
    -> Fine tune by sorting options
    -> Fine tune by selecting only X IP address, or X web address, etc
```

#### Setup
```bash
# clone this repo
git clone https://github.com/dostoevskylabs/engagement-scripts.git && cd engagement-scripts && chmod +x env.sh
# init your environment
./env.sh
# name your project
> YourProject
```

#### Phase 1
```bash
cd YourProject/Phase-1/
# Add targets (hostnames or IP addresses separated by a newline)
vi targets
# Run your nmap campaign
./xxx-master.sh
# Viewing Results
cd ../results && ./parse-nmap.sh
```

#### Phase 2
```bash
cd YourProject/Phase-2/
# Add domains (full URLs to the directory you wish to dirbust separated by a newline)
vi domains
# Run your dirfuzz campaign
./dirfuzz.sh -w path/to/wordlist -t threadcount
# Viewing Results
cd ../results && ./parse-dirfuzz.sh
```

