# NOTE: to get a list of npm packages (without all their dependencies) and paste it into this list, run:
# npm list -g --depth=0 > installedNPMpackages.txt

packagesList=" \
ttab \
buzzphrase \
csv-to-md \
markdown-styles \
ttab"

# Other potentially used packages:
# ungit

for element in ${packagesList[@]}
do
  npm install -g $element
done