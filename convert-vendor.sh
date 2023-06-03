#!/bin/bash

PWD="$(pwd)"
SRC="/opt/librenms/mibs"
DEST="/opt/librenms/dictionaries"

if [ -z "$1" ]
then
    echo "Usage: $0 <Vendor MIB directory to convert>"
    exit 1
fi

cd "$SRC/$1"
mkdir -p "$DEST/$1"

for FILE in $(ls -l | grep -vE '^d' | awk '{print $9}')
do
    if [ -n "$FILE" ]
    then
        smidump --level=1 -k -f python $FILE > $DEST/$1/${FILE}.dic
    fi
done

cd "$PWD"
