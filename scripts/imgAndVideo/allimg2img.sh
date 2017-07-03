# IN PROGRESS.

# DESCRIPTION: converts all images of one type in a directory tree to another.

# USAGE: invoke this script with these parameters:
# $1 the source file format e.g. eps or svg
# $2 the target file format e.g. tif or jpg

# DEV NOTE: template command: gm -size 850 test.svg result.tif
# NOTE that for the -size parameter, it scales the imagesso that the longest side is that many pixels.

img_format_1=$1
img_format_2=$2

find . -iname \*.$img_format_1 > all_"$img_format_1".txt
while read element
do
	fileNameNoExtension=`basename $element .$img_format_1`
			# REFERENCE for script hacking for custom runs: the [-scale n] switch will resize the image maintaining aspect with the longest side at n pixels.
	# what parameter was I after here? : -size $1x$1
	command="gm convert $element $fileNameNoExtension.$img_format_2 -scale 640"
	echo running command\: $command
	echo . . .
	$command
done < all_"$img_format_1".txt

rm all_imgs.txt
