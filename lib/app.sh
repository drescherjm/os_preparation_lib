#------------------------------------
# Define lib path
#------------------------------------
#LIB="${OS_PREPARATION_LIB}/lib"   # This var move to start.sh

#------------------------------------
# Include libaries
#------------------------------------
echo $LIB
LIB_SCRIPTS="$(ls $LIB |grep -E "^L_[0-9][0-9]_[^[:space:]]+(.sh)$" | sort -n)"
for LIB_SCRIPT in $LIB_SCRIPTS
do
  . $LIB/$LIB_SCRIPT
  #echo "$LIB_SCRIPT"
done
#exit
