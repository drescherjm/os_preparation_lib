#-----------------------------------------------------------------------------------------
# Before everything clean all yum / dnf cache
#-----------------------------------------------------------------------------------------
OS_RELEASE_VER="$(cat /etc/centos-release |grep 'release 8')"

if [[ -n "${OS_RELEASE_VER}" ]]; then
  REPO_EXEC_CMD="dnf"
else
  REPO_EXEC_CMD="yum"
fi


$REPO_EXEC_CMD clean all >/dev/null 2>/dev/null

############### Fetch dnf repo retry Loop (For epel-modular) #############
#let dnf_repo_install_retry++
#for ((i=1; i<=dnf_repo_install_retry; i++)); do
echo "Updating ${REPO_EXEC_CMD} Repo list....."

for ((i=1; ; i++)); do

  # ---------- Check DNF Repo Installation -----------
  DNF_REPO_CHECK="$($REPO_EXEC_CMD repolist >/dev/null 2>/dev/null && echo "Success")"
  if [[ -n "${DNF_REPO_CHECK}" ]]; then
    echo "${REPO_EXEC_CMD} Repo is updated successfully!"
    break
  fi

  if [[ -z "${DNF_REPO_CHECK}" ]]; then
    echo "${REPO_EXEC_CMD} Repo is not updated yet!"
    #[[ $i -eq $dnf_repo_install_retry ]] && exit
    [[ $i -gt $dnf_repo_install_retry ]] && exit
  fi

  echo -n "${REPO_EXEC_CMD} Repo updating (try: $i) "
  #sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; echo ""
  sleep 1; echo -n "."; echo ""
done

echo ""
############### Fetch dnf repo retry Loop (For epel-modular) #############
