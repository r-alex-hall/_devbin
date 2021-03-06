# DESCRIPTION
# Prints a list of all files matching many image etc. file types in the current directory, and optionally all subdirectories. To create an array from the list, see USAGE.

# USAGE
# Run without any parameter:
#    printAllIMGfileNames.sh
# To use this from another script to create an array from the output, do this:
#    allIMGfileNamesArray=($(printAllIMGfileNames.sh))
# -- you may then iterate through it like this:
#    for element in ${allIMGfileNamesArray[@]}; do <something with $element>; done
# By default, the script only prints files in the current directory, but if you pass any parameter to the script (for example the word 'BROGNALF'), it will also (find and) print image file names from subdirectories:
#    printAllIMGfileNames.sh BROGNALF
# NOTE
# Because some tools are silly and create files with uppercase extensions, this script searches for both lowercase and uppercase extensions of every file type in its list.


# CODE
# If no parameter one, maxdepthParameter will be left at default, which causes find to search only the current directory:
maxdepthParameter='-maxdepth 1'
# If parameter one is passed to script, that changes to nothing, and find's default recursive search will be used (as no maxdepth switch will be passed) :
if [ "$1" ]; then maxdepthParameter=''; fi

# array of file types in lowercase; will programmatically build `find` command that searches for these *and* uppercase versions (because some devices and programs are silly and write uppercase extensions) :
filetypes=(
tif
tiff
png
tga
psd
psb
ora
rif
riff
jpg
jpeg
gif
bmp
cr2
raw
dng
crw
kra
ptg
)

# build string listing lowercase and also uppercase extensions list section for `find` command:
fileTypesWithAlsoUppercase=
for type in ${filetypes[@]}
do
	typesParam+="-o -iname \*.$type -o -iname \*.${type^^} "
done

# I'm only getting this to work in a temp script that I create, write the command to, executed and then delete. By itself with whatever escaping I find, or in a variable expanded to a command, it breaks; CHORFL is just to meet a requirement of starting the list withuot -o:
echo "find ./ $maxdepthParameter -type f \( -iname \*.CHORFL $typesParam \) -printf \"%P\n\"" > tmpScript_bxJZuSvKq.sh
./tmpScript_bxJZuSvKq.sh
rm ./tmpScript_bxJZuSvKq.sh