#!/bin/bash

# Iterates individually through the files/dirs in $DIRPATH, makes an uncompressed tar 
# out of the file/dir found, pipes the new tar to gpg to encrypt, and finally the 
# newly encrypted tar is to $DIRPATH while deleting the original

# A pre-existing public/private key pair in gpg is necessary for the script to function.

# Change these constants to use the script
DIRPATH="/path/to/dir"
RECIPIENTADDR="exampleemail@mail.com"

for i in $DIRPATH/*
	do
		localFileName=$(basename "$i") # Stores local file name without its full path
		sse=$(echo $EPOCHREALTIME) # Seconds since epoch used as a new unique file name
		
		if [[ $localFileName != *.gpg ]]; then # If files that aren't encrypted are in dir		
			tar -cvf - -C $DIRPATH "$localFileName" | gpg --encrypt --recipient $RECIPIENTADDR > "$DIRPATH/$sse.tar.gpg"
			rm -rf "$i"
			
		else
			echo "skipping $localFileName..."
		
		fi


done
