L_UPDATE_REPO() {
  #-----------------------------------------------------------------------------------------
  # Before everything clean all yum / dnf cache
  #-----------------------------------------------------------------------------------------
  local first_param="$1"
  local os_release_ver="$(cat /etc/centos-release |grep 'release 8')"

  if [[ -n "${os_release_ver}" ]]; then
    local repo_exec_cmd="dnf"
  else
    local repo_exec_cmd="yum"
  fi


  $repo_exec_cmd clean all >/dev/null 2>/dev/null

  #if [[ -n "${os_release_ver}" ]]; then
    ############### Fetch dnf repo retry Loop (For epel-modular) #############
    local dnf_repo_install_retry=5000

    if [[ -n "${first_param}" ]]; then
      dnf_repo_install_retry="${first_param}"
    fi

    #let dnf_repo_install_retry++
    #for ((i=1; i<=dnf_repo_install_retry; i++)); do
    echo "Updating ${repo_exec_cmd} Repo list....."

    for ((i=1; ; i++)); do

      # ---------- Check DNF Repo Installation -----------
      local dnf_repo_check="$($repo_exec_cmd repolist >/dev/null 2>/dev/null && echo "Success")"
      if [[ -n "${dnf_repo_check}" ]]; then
        echo "${repo_exec_cmd} Repo is updated successfully!"
        break
      fi

      if [[ -z "${dnf_repo_check}" ]]; then
        echo "${repo_exec_cmd} Repo is not updated yet!"
        [[ $i -gt $dnf_repo_install_retry ]] && exit
      fi

      echo -n "${repo_exec_cmd} Repo updating (try: $i) "
      #sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; echo ""
      sleep 1; echo -n "."; echo ""
    done

    echo ""
    ############### Fetch dnf repo retry Loop (For epel-modular) #############
  #fi
}

