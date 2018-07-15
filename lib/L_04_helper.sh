#-----------------------------------------------------------------------------------------
# Convert functions into function
#-----------------------------------------------------------------------------------------
for HELPER_NAME in ${HELPER_NAMES[@]}
do
  HELPER_VIEW_FOLDER="${HELPERS_VIEWS}/${HELPER_NAME}"
  MAKE_FUNC="
  ${HELPER_NAME} (){
    echo \"HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH\"
    echo \"        ${HELPER_NAME}\"
    echo \"HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH\"

    HELPER_VIEW_FOLDER=\"${HELPER_VIEW_FOLDER}\"
    . ${HELPERS}/${HELPER_NAME}.sh
    cd $CURRENT_FOLDER
  }
  "
  eval "${MAKE_FUNC}"
  #echo "${MAKE_FUNC}" #debug use
done

