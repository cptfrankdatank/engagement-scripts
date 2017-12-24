#!/bin/bash
echo ""
echo "Gobuster Controller v0.0.1"
echo "Killing previous instances of gobuster"
echo ""
killall -q gobuster
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -w|--wordlist)
    wordlist="$2"
    shift # past argument
    shift # past value
    ;;
    -t|--threads)
    threads="$2"
    shift # past argument
    shift # past value
    ;;    
esac
done

if [ -z ${wordlist} ]; then
        wordlist="/usr/share/wordlists/fuzzdb/discovery/predictable-filepaths/filename-dirname-bruteforce/raft-large-words-lowercase.txt"
fi

if [ -z ${threads} ]; then
        threads=10
fi

if [ ! -f "$wordlist" ]; then
        echo "Path to wordlist is invalid, please use a valid path to a line separated wordlist"
        exit
fi

if [ ! -d "gobuster-results" ]; then
        mkdir gobuster-results
fi

if [ ! -f "domains" ]; then
        echo "Create a `domains` file with full url(s) seperated by new lines to run your campaigns against"
        exit
fi

echo "Launching campaign..."
echo "Wordlist: $wordlist"
echo "Threads: $threads"
echo ""
for item in $(cat domains) ; do
        savepath=$(echo $wordlist | rev | cut -d "/" -f1 | rev);
        filename=$(echo $item | cut -d "/" -f3- | tr "/" "-");
        if [ ! -d "gobuster-results/$savepath" ]; then
                mkdir gobuster-results/$savepath
        fi
        echo "gobuster-results/$savepath/$filename"
        gobuster -w $wordlist -u $item -t $threads > gobuster-results/$savepath/$filename &
done
