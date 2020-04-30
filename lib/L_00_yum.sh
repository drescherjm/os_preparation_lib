L_UPDATE_REPO() {
  #-----------------------------------------------------------------------------------------
  # Before everything clean all yum / dnf cache
  #-----------------------------------------------------------------------------------------
  local first_param="$1"


  $REPO_EXEC_CMD clean all >/dev/null 2>/dev/null

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
      local dnf_repo_check="$($REPO_EXEC_CMD repolist >/dev/null 2>/dev/null && echo "Success")"
      if [[ -n "${dnf_repo_check}" ]]; then
        echo "${REPO_EXEC_CMD} Repo is updated successfully!"
        break
      fi

      if [[ -z "${dnf_repo_check}" ]]; then
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

