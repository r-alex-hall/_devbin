# DESCRIPTION: returns one password of length 44 characters or per paramaters you pass to the script.

# USAGE: pass this script two paramaters, the first being how many strings you want it to return, the second being the length of each string.


# TO DO: update this to use the better means of empty variable checkign I found; e.g if [ -z ${1+x} ]; then img_size=4120; else img_size=$1; fi :
if [[ $1 == "" ]]; then howMany=1; else howMany=$1; fi
if [[ $2 == "" ]]; then length=44; else length=$2; fi
for (( i=1; i<=$howMany; i++ ))
do
	cat /dev/urandom | tr -dc 'a-z0-9A-Z{}[]~!@#$%^&*()_+-' | head -c $length
		# For newline between printed strings:
		echo
done


# DEVELOPMENT LOG:
# 2016-05-05 4:18 PM RAH horked from randomString.sh; see comments therein for reference.
# 01/03/2017 10:15:50 PM RAH removed the characters =<> from the tr -dc '...' parameter, as they produced commas which hurt passwords in some settings (and may not have ever produced any of the characters =<>).