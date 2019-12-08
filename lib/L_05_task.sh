#-----------------------------------------------------------------------------------------
# Convert functions into function
#-----------------------------------------------------------------------------------------
for TASK_NAME in ${TASK_NAMES[@]}
do
  MAKE_FUNC="
  ${TASK_NAME} (){
    echo -e '\\e[1;35m'
    echo \"-----------------------------------------------\"
    echo \"        ${TASK_NAME}\"
    echo \"-----------------------------------------------\"
    echo -n -e '\\033[00m'
    echo -n -e '\\e[0;35m'

    . ${TASKS}/${TASK_NAME}.sh
    cd $CURRENT_FOLDER
    echo -e '\\033[00m'
  }
  "
  eval "${MAKE_FUNC}"
  #echo "${MAKE_FUNC}" #debug use
done

