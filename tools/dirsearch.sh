if ! [ -x "$(dirsearch)" ]; then
  echo "dirsearch not found in /usr/bin" >&2
  exit
fi
dirsearch -L domains $@ --json-report="../../results/dirsearch/output.json"
