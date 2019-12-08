#-----------------------------------------------------------------------------------------
# Convert functions into function
#-----------------------------------------------------------------------------------------
for HELPER_NAME in ${HELPER_NAMES[@]}
do
  HELPER_VIEW_FOLDER="${HELPERS_VIEWS}/${HELPER_NAME}"
  MAKE_FUNC="
  ${HELPER_NAME} (){
    echo -e '\\e[1;31m'
    echo \"----------------------------------------------------\"
    echo \"        ${HELPER_NAME}\"
    echo \"----------------------------------------------------\"
    echo -n -e '\\033[00m'
    echo -n -e '\\e[0;31m'

    HELPER_VIEW_FOLDER=\"${HELPER_VIEW_FOLDER}\"
    . ${HELPERS}/${HELPER_NAME}.sh
    cd $CURRENT_FOLDER
    echo -e '\\033[00m'
  }
  "
  eval "${MAKE_FUNC}"
  #echo "${MAKE_FUNC}" #debug use
done

