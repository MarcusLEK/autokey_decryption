#!/usr/bin/bash

a="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

#check if file is provided
if [ $# != 1 ]
then
	echo "Usage: $0 <textfile>"
else
	echo "" > autokey_decrypt.tmp

# inputs
pt=$(cat $1 | tr -d [:space:])
printf "keyword: ";read kw
printf "\n"

# convert to upper
t=$(echo $pt | tr [:lower:] [:upper:])
autok=$(echo $kw | tr [:lower:] [:upper:])

#keyword length check
if [ ${#autok} -lt 7 ]
then
	echo "Keyword must be atleast 7 chars long"
else 
	#generate new keyword
	s=$(( ${#p} - ${#autok} ))
	k=$(echo $autok${t:0:$s})
	#printf "Keyword:"; echo $k

currentKey=$autok
msg=""

# decryption
for ((i=0;i<${#t};i++)); do
    first=$(echo $a | grep -aob ${t:i:1} | grep -oE '[0-9]+')
    second=$(echo $a | grep -aob ${currentKey:i:1} | grep -oE '[0-9]+')    
    total=$(( $first - $second ))
    total2=$(( $total % 26 ))
    if (( $total2 < 0 ))
    then
        total3=$(( $total2 + 26 ))
    else
        total3=$total2
    fi
    msg+=${a:$total3:1}
    currentKey+=${a:$total3:1}
done

#write to file
echo "$msg" > autokey_decrypt.tmp && mv autokey_decrypt.tmp autokey_decrypt.txt 
fi    
fi
