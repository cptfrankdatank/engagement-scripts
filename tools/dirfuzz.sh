#!/bin/bash
echo ""
echo "DirFuzz"
echo ""
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -w|--wordlist)
    wordlist="$2"
    shift # past argument
    shift # past value
    ;;
    -k|--kill)
    echo "Killed previously running instances of GoBuster"
    killall -q gobuster
    exit
    shift
    shift
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

if [ ! -f "domains" ]; then
        echo "Create a domains file with full url(s) seperated by new lines to run your campaigns against"
        exit
fi

echo "Launching campaign..."
echo "Wordlist: $wordlist"
echo "Threads: $threads"
echo ""
for item in $(cat domains) ; do
        filename=$(echo $wordlist | rev | cut -d "/" -f1 | rev);
        savepath=$(echo $item | cut -d "/" -f3- | tr "/" "-");
        if [ ! -d "../../results/dirfuzz/$savepath" ]; then
                mkdir ../../results/dirfuzz/$savepath
        fi
        echo "../../results/dirfuzz/$savepath/$filename"
        gobuster -w $wordlist -u $item -t $threads > ../../results/dirfuzz/$savepath/$filename &
done
