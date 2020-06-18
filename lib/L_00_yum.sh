L_UPDATE_REPO() {
  #-----------------------------------------------------------------------------------------
  # Before everything clean all yum / dnf cache
  #-----------------------------------------------------------------------------------------
  local first_param="$1"


  #$REPO_EXEC_CMD clean all >/dev/null 2>/dev/null
  $REPO_EXEC_CMD clean all

  #if [[ "${OS_RELEASE_VER}" -eq 8 ]]; then
    ############### Fetch dnf repo retry Loop (For epel-modular) #############
    local dnf_repo_install_retry=5000

    if [[ -n "${first_param}" ]]; then
      dnf_repo_install_retry="${first_param}"
    fi

    #let dnf_repo_install_retry++
    #for ((i=1; i<=dnf_repo_install_retry; i++)); do
    echo "Updating ${REPO_EXEC_CMD} Repo list....."

    for ((i=1; ; i++)); do

      # ---------- Check DNF Repo Installation -----------
      $REPO_EXEC_CMD makecache
      local dnf_repo_check=$?
      if [[ ${dnf_repo_check} -eq 0 ]]; then
        echo "${REPO_EXEC_CMD} Repo is updated successfully!"
        break
      fi

      if [[ ${dnf_repo_check} -ne 0 ]]; then
        echo "${REPO_EXEC_CMD} Repo is not updated yet!"
        [[ $i -gt $dnf_repo_install_retry ]] && exit
      fi

      echo -n "${REPO_EXEC_CMD} Repo updating (try: $i) "
      #sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; echo ""
      sleep 1; echo -n "."; echo ""
    done

    echo ""
    ############### Fetch dnf repo retry Loop (For epel-modular) #############
  #fi
}

# ----------------------------------------------------------------------------------
#                   yum/dnf cache never expire
# ----------------------------------------------------------------------------------
#L_STOP_EXPIRING_REPO_CACHE() {
#  if [[ "${OS_RELEASE_VER}" -eq 8 ]]; then
#    echo "---------------------------------------------------------------------------"
#    echo 'Setting dnf metadata_expire to -1 !!'
#    echo ""
#    echo "Better DO this , before installing packages:"
#    echo "  dnf makecache"
#    echo ""
#    echo "Revert to default: "
#    echo "  sed -i '/metadata_expire/d' /etc/dnf/dnf.conf"
#    echo "---------------------------------------------------------------------------"
#    echo ""
#    dnf config-manager --setopt metadata_expire=-1 --save
#  else
#    echo "---------------------------------------------------------------------------"
#    echo 'Setting yum metadata_expire to never !!'
#    echo ""
#    echo "Better DO this , before installing packages:"
#    echo "  yum makecache"
#    echo ""
#    echo "Revert to default: "
#    echo "  sed -i '/metadata_expire/d' /etc/yum.conf"
#    echo ""
#    echo "---------------------------------------------------------------------------"
#    echo ""
#    sed -i '/metadata_expire/d' /etc/yum.conf
#    echo 'metadata_expire=never' >> /etc/yum.conf
#  fi
#}
# ----------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------
#         yum/dnf cache default expire setting
# ----------------------------------------------------------------------------------
# Disable repo cache expiration all the time
# Instead, using dnf-automatic / yum-cron to makecache

#L_START_EXPIRING_REPO_CACHE() {
#  if [[ "${OS_RELEASE_VER}" -eq 8 ]]; then
#    #sed -i '/metadata_expire/d' /etc/dnf/dnf.conf
#    echo ""
#  else
#    sed -i '/metadata_expire/d' /etc/yum.conf
#  fi
#}
# ----------------------------------------------------------------------------------
