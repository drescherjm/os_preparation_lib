RENDER_CP (){
  local cp_from=$1
  local cp_to=$2

  # -----Check if dollar sign without escape in template config files----
  local check_template="$(cat ${cp_from} |grep -E "[^\]+[$]+[a-zA-Z]+")"
  if [ ! -z "${check_template}" ]
  then
    check_template_currected="$(echo "${check_template}" | sed 's/[$]/\\$/')"
    echo "Template file contains wrong usage, please currect it as below......"
    echo ""
    echo "${cp_from} : "
    echo "${check_template} --->"
    echo "${check_template_currected}"
    exit 1
  fi
  # -----Check if dollar sign without escape in template config files----


  echo "rendering file \"${cp_to}\""
  eval "echo \"$(cat ${cp_from})\" > ${cp_to}"
}

RENDER_CP_SED (){
  local cp_from=$1
  local cp_to=$2
  #local render_params="$(cat ${DATABAG_FILE} |grep -vE "^[[:space:]]*#" | grep -Eo "[[:space:]]*[^[:space:]]+=[\"']" | sed -r -e "s/[[:space:]=\"']*//g" | sort -n | uniq)"
  local render_params="$(cat ${cp_from} | grep -Eo '\{\{[-_[:alnum:]]+\}\}' | sed -r -e 's/\{|\}//g' | sort -n | uniq)"
  

  #----- Start to render template -----
  echo "Rendering file \"${cp_to}\" (using sed)"

  cat ${cp_from} > ${cp_to}
  for render_param in $render_params; do
    local render_param_value="$(
      echo "${!render_param}" | \
      sed -r \
          -e 's/\\/\\\\\\/g' \
          -e 's/\//\\\//g' \
          -e 's/\&/\\\&/g' \
      )"

    sed -r -e "s/\{\{${render_param}\}\}/${render_param_value}/g" -i ${cp_to}

  done
}
