#-------------------------------------------------
# Function
#-------------------------------------------------
#CHECK_IF_VAR_EXISTS_IN_REGEX() {
#}

CHECK_IF_VAR_EXISTS_IN() {
  local check_keyword="$1"
  local check_from_keywords="$2"
  local check_return='false'
  for check_from_keyword in ${check_from_keywords[@]}; do
    if [[ "${check_keyword}" == "${check_from_keyword}" ]]; then
      check_return='true'
    fi
  done
  echo "${check_return}"
}

SAFE_DELETE () {
  local delete_files="$(readlink -m $1)"
  local skip_files="$((find / -maxdepth 1 ;  readlink -m /* )|sort -n |uniq)"
  local if_error_exists='false'

  # --- check of exists in skip_files ---
  for delete_file in ${delete_files[@]}; do
    local if_exists="$(CHECK_IF_VAR_EXISTS_IN "${delete_file}" "${skip_files}")"
    if [[ "${if_exists}" == 'true' ]]; then
      echo "FATAL ERROR: deleting ${delete_file} is NOT allowed..."
      if_error_exists='true'
    fi
  done

  # --- check if exists in skip_files ---
  if [[ "${if_error_exists}" == 'true' ]]; then
    echo "[FATAL ERROR] founds ... exit process..."
    exit 1
  fi

  # --- start to delete safe files ---
  for delete_file in ${delete_files[@]}; do
    echo "Deleting ${delete_file} ..."
    rm -fr ${delete_file}
  done
}

#-------------------------------------------------
# Usage:
# SAFE_DELETE "{FILE|FOLER}"
#-------------------------------------------------
# --- TEST Sample Code ---
# DELETE_FROM="/root/delete_me"
# SAFE_DELETE "${DELETE_FROM}"
