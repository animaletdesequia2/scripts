#/bin/bash
index="$1"
# Main loop:
if [ ! -f "$index" -o "$index" == "" ]
	then
    		echo "I need an existing index file as a first argument!"
		exit 1
	else
    		echo "Using $index as a source for files."
		echo " "
		mkdir indextmp
		for i in $(cat $index)
			do
				echo "Including $i in the upload..."
				cp -r --parents $i indextmp/
		done
	now=`date +%Y_%m_%d__%H_%M_%S`
	echo " "
	echo "Compressing files..."
	echo " "
	tar -czv indextmp -f upload-$now.tar.gz
	rm -r indextmp
	echo " "
	echo "Temporal files removed. Uploading compressed files..."
	echo " "
	scp upload-$now.tar.gz krypto.nefeles.es:/root/
	echo " "	
	echo "Done"
	echo " "
exit 0
fi
