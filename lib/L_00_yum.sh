#-----------------------------------------------------------------------------------------
# Before everything clean all yum / dnf cache
#-----------------------------------------------------------------------------------------
OS_RELEASE_VER="$(cat /etc/centos-release |grep 'release 8')"

if [[ -n "${OS_RELEASE_VER}" ]]; then
  EXEC_CMD="dnf"
else
  EXEC_CMD="yum"
fi


$EXEC_CMD clean all >/dev/null 2>/dev/null

############### Fetch dnf repo retry Loop (For epel-modular) #############
#let dnf_repo_install_retry++
#for ((i=1; i<=dnf_repo_install_retry; i++)); do
echo "Updating ${EXEC_CMD} Repo list....."

for ((i=1; ; i++)); do

  # ---------- Check DNF Repo Installation -----------
  local dnf_repo_check="$($EXEC_CMD repolist >/dev/null 2>/dev/null && echo "Success")"
  if [[ -n "${dnf_repo_check}" ]]; then
    echo "${EXEC_CMD} Repo is updated successfully!"
    break
  fi

  if [[ -z "${dnf_repo_check}" ]]; then
    echo "${EXEC_CMD} Repo is not updated yet!"
    #[[ $i -eq $dnf_repo_install_retry ]] && exit
    [[ $i -gt $dnf_repo_install_retry ]] && exit
  fi

  echo -n "${EXEC_CMD} Repo updating (try: $i) "
  #sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; echo ""
  sleep 1; echo -n "."; echo ""
done

echo ""
############### Fetch dnf repo retry Loop (For epel-modular) #############
