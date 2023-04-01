#------------------------------------
# Define params
#------------------------------------
OS_NAME="$(cat /etc/os-release |grep -i pretty_name | cut -d'"' -f2 | grep -Eo "[[:print:]]+[[:digit:]\.]+")"
OS_RELEASE_VER="$(cat /etc/os-release  |grep -iE "^version_id" | grep -oE "[[:digit:]\.]+")"

#if [[ "${OS_RELEASE_VER}" -eq 7 ]]; then
#  REPO_EXEC_CMD="yum"
#else
  REPO_EXEC_CMD="dnf"
#fi

#------------------------------------
# Define lib path
#------------------------------------
LIB="${OS_PRE_LIB}/lib"

#------------------------------------------------------------------------------------------------------------
# do something BEFORE ALL FUNCTIONS HERE
#------------------------------------------------------------------------------------------------------------
# do something here
# --- make sure this is for CentOS only ---
IS_ROCKY="$(echo ${OS_NAME} | grep -i "rocky")"
if [[ -z "${IS_ROCKY}" ]]; then
  echo "Make sure run this preparation under OS \"Rocky\""
  exit
fi


#------------------------------------
# Include libaries
#------------------------------------
LIB_SCRIPTS="$(ls $LIB |grep -E "^L_[0-9][0-9]_[^[:space:]]+(.sh)$" | sort -n)"
for LIB_SCRIPT in $LIB_SCRIPTS
do
  . $LIB/$LIB_SCRIPT
  #echo "$LIB_SCRIPT"
done
#exit


#------------------------------------------------------------------------------------------------------------
# do something AFTER ALL FUNCTIONS HERE
#------------------------------------------------------------------------------------------------------------
# do something here

