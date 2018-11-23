#!/bin/sh

echo "Input filename:$1"

hexdump $1 -n 10 -C | grep BOOTLOADER

if [ $? -eq 0 ]; then
	ls -l $1
	echo "Header included! Remove the header!"
	dd bs=1024 skip=128 if=$1 of="$1"".header_truncated"
	ls -l "$1"".header_truncated"
else
	echo "Header not included!"
fi

