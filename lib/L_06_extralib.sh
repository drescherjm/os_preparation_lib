#-----------------------------------------------------------------------------------------
# Determine is current block is sourced script or function
# If yes, please use 'return 0' to skip current block, and continue the whole script
# Otherwised, please use 'exit 0'!
# Usage: Use the following command in your script.
#       eval "${IF_IS_SOURCED_OR_FUNCTION}"
# Example:
#         [[ -n "$(eval "${IF_IS_SOURCED_OR_FUNCTION}")" ]] && return 0 || exit 0
#-----------------------------------------------------------------------------------------

IF_IS_SOURCED_SCRIPT="$(cat <<EOF
if [[ "\${BASH_SOURCE[0]}" != "\${0}" ]]; then
  echo "Is this a sourced script: true    #use 'return 0' to skip script"
fi
EOF
)"

IF_IS_FUNCTION="$(cat <<EOF
if [[ -n "\${FUNCNAME}" ]]; then
  echo "Is this a function: true    #use 'return 0' to skip script"
fi
EOF
)"

IF_IS_SOURCED_OR_FUNCTION="$(cat <<EOF
if [[ -n "\$(eval "\${IF_IS_SOURCED_SCRIPT}")" ]] || [[ -n "\$(eval "\${IF_IS_FUNCTION}")" ]]; then
  echo "Is this a sourced script or function: true    #use 'return 0' to skip script"
fi
EOF

