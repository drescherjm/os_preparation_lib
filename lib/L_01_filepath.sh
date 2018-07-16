#-----------------------------------------------------------------------------------------
# Filepath Setup
#-----------------------------------------------------------------------------------------
#***** lib use ******
#CURRENT_SCRIPT="$(readlink -m $0)"  # This var move to start.sh
#CURRENT_FOLDER="$(dirname "${CURRENT_SCRIPT}")"  # This var move to start.sh
FUNCTIONS="${CURRENT_FOLDER}/functions"

#***** script use ******
PLUGINS="${CURRENT_FOLDER}/plugins"

#***** helper use ******
HELPERS="${CURRENT_FOLDER}/helpers"

#***** task use ******
TASKS="${OS_PRE_LIB}/tasks"

#***** functions use ******
TEMPLATES="${CURRENT_FOLDER}/templates"
DATABAG="${CURRENT_FOLDER}/databag"
TMP="${CURRENT_FOLDER}/tmp"

HELPERS_VIEWS="${CURRENT_FOLDER}/helpers_views"
# * Defined in lib/function.sh
# CONFIG_FOLDER ===> ${TEMPLATES}/{FUNC_NAME}

#-----------------------------------------------------------------------------------------
# lib use only - special variables
#-----------------------------------------------------------------------------------------
FUNC_NAMES=($(ls $FUNCTIONS | grep -E "^F_[0-9][0-9]_[^[:space:]]+(.sh)$" | sort -n | sed 's/\.sh$//g'))
FIRST_ARGV=$1 ; shift
ALL_ARGVS=($@)

#-----------------------------------------------------------------------------------------
# lib use only - helper
#-----------------------------------------------------------------------------------------
HELPER_NAMES=($(ls $HELPERS | grep -E "^helper_[^[:space:]]+(.sh)$" | sort -n | sed 's/\.sh$//g'))

#-----------------------------------------------------------------------------------------
# lib use only - task
#-----------------------------------------------------------------------------------------
TASK_NAMES=($(ls $TASKS | grep -E "^[_]?task_[^[:space:]]+(.sh)$" | sort -n | sed 's/\.sh$//g'))

