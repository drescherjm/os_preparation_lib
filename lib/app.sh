#------------------------------------
# Define params
#------------------------------------
OS_RELEASE_VER="$(cat /etc/centos-release | grep -Eo 'release [[:digit:]]+' | awk '{print $2}')"

if [[ "${OS_RELEASE_VER}" -eq 8 ]]; then
  REPO_EXEC_CMD="dnf"
else
  REPO_EXEC_CMD="yum"
fi

#------------------------------------
# Define lib path
#------------------------------------
LIB="${OS_PRE_LIB}/lib"

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


#-----------------------------------------------------------------------------------------
# NTP update date time and hwclock to prevent mariadb cause systemd warning
#-----------------------------------------------------------------------------------------
rpm --quiet -q chrony || $REPO_EXEC_CMD install -y chrony
# make sure chronyd stop first , before syncing time using chronyd command!
systemctl stop chronyd
systemctl disable chronyd
chronyd -q 'pool pool.ntp.org iburst'

hwclock -w
