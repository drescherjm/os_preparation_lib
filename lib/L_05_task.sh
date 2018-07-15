#-----------------------------------------------------------------------------------------
# Convert functions into function
#-----------------------------------------------------------------------------------------
for TASK_NAME in ${TASK_NAMES[@]}
do
  MAKE_FUNC="
  ${TASK_NAME} (){
    echo \"______________________________\"
    echo \"        ${TASK_NAME}\"
    echo \"______________________________\"

    . ${TASKS}/${TASK_NAME}.sh
    cd $CURRENT_FOLDER
  }
  "
  eval "${MAKE_FUNC}"
  #echo "${MAKE_FUNC}" #debug use
done

