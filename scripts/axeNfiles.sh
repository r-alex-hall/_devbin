# DESCRIPTION
# Splits all files in the current directory of type $1 into subdirectories by multiples of $2 (axe files into folders), with folder prefix name $3.

# USAGE
# ./thisScript.sh fileExtension numberOfFilesToAxePerFolder _folderPrefixName_


# CODE

# ====
# BEGIN SET GLOBALS
# Parse for parameters and set defaults for missing ones\; if they are present\, use them.
if [ -z ${1+x} ]
then
	echo No file format parameter \$1 passed to script\; setting to default png.
	fileExt=png
else
	fileExt=$1; echo fileExt set to parameter \$1\, $1\.
fi

if [ -z ${2+x} ]
then
	echo No axe by N files paramater \$2 passed to script\; setting to default 8\.
	numberToAxeOn=8
else
	numberToAxeOn=$2; echo numberToAxeOn set to parameter \$2\, $2\.
fi

if [ -z ${3+x} ]
then
	echo No _folderPrefixName parameter \$3 passed to script\; setting to default _toEndFR_.
	folderPrefix=_toEndFR_
else
	folderPrefix=$3; echo folderPrefix set to parameter \$3\, $3\.
fi

# Count number of files so we can figure out how many 0 columns to pad numbers with via printf:
numberOfFiles=$(find . -maxdepth 1 -iname "*.$fileExt" | wc -l)
		echo Found $numberOfFiles files of type $fileExt.
padToDigits=${#numberOfFiles}
		echo Will pad numbers in folder names to $padToDigits digits.
# ====
# END SET GLOBALS

# MAIN LOGIC
# Adapted from and thanks to a genius breath yon; https://stackoverflow.com/a/29118145 -- for axing files in subdirs into subdirs by count, check another answer there:
n=$((`find . -maxdepth 1 -iname "*.$fileExt" | wc -l`/$numberToAxeOn))
for i in `seq 1 $n`;
do
	zeroPaddedNumber=`printf "%0"$padToDigits"d" $i`
			# echo padded number for folder name is $zeroPaddedNumber . . .
    if ! [ -d $folderPrefix"$zeroPaddedNumber" ]; then mkdir $folderPrefix"$zeroPaddedNumber"; fi
    find . -maxdepth 1 -iname "*.$fileExt" | head -n $numberToAxeOn | xargs -i mv "{}" $folderPrefix"$zeroPaddedNumber"
done

echo Checking for remainder files that weren\'t sorted into a numbered folder:
stragglerCount=`find . -maxdepth 1 -iname "*.$fileExt" | wc -l`
		echo Stragglers found\: $stragglerCount
if [ $stragglerCount -ne 0 ]
then
			echo Because that\'s nonzero I\'ll make another folder and move stragglers into it.
			# echo i was $i
	i=$(($i + 1))
			# echo i is now $i . . .
	zeroPaddedNumber=`printf "%0"$padToDigits"d" $i`
			# echo padded number for folder name is $zeroPaddedNumber . . .
    if ! [ -d $folderPrefix"$zeroPaddedNumber" ]; then mkdir $folderPrefix"$zeroPaddedNumber"; fi
	mv *.$fileExt ./$folderPrefix"$zeroPaddedNumber"/
else
			echo Because there are no stragglers\, I\'ll do nothing more.
fi

numeralOneToPadToDigits=`printf "%0"$padToDigits"d" 1`
echo DONE. All files in this folder of type $fileExt have been axed by count $numberToAxeOn into folders named starting $folderPrefix"$numeralOneToPadToDigits" and ending $folderPrefix"$zeroPaddedNumber" \(if those are both the same folder name\, they are all in that one folder\)\.