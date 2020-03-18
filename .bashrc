# Toggle between normal PS1 and alternative (short) PS1
# Usage:
#     toggle-prompt
#         Toggle between normal and alternative PS1
#     toggle-prompt help           [aliases: h, -h, --help]
#         Show help
#     toggle-prompt PS1 <value>    [alias: ps1]
#         Change alternative PS1 to a new value
#
# Repository: https://github.com/davidstraka2/toggle-prompt
# Bugs: https://github.com/davidstraka2/toggle-prompt/issues
TOGGLE_PROMPT_PS1="-> "
__TOGGLE_PROMPT_PS1_FULL=$PS1
__TOGGLE_PROMPT_STATE=1
function toggle-prompt () {
    # If help is requested, show help
    if [[ "$1" == "h" || "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]
    then
        echo -e "Toggle between normal PS1 and alternative (short) PS1"\
            "\nUsage:"\
            "\n    $FUNCNAME"\
            "\n        Toggle between normal and alternative PS1"\
            "\n    $FUNCNAME help           [aliases: h, -h, --help]"\
            "\n        Show help"\
            "\n    $FUNCNAME PS1 <value>    [alias: ps1]"\
            "\n        Change alternative PS1 to a new value"
    # Else if change of the alternative PS1 is requested
    elif [[ "$1" == "PS1" || "$1" == "ps1" ]]
    then
        # Change the alternative PS1
        TOGGLE_PROMPT_PS1="$2"
        # If the current state is toggled to show alternative PS1, update PS1
        if [ $__TOGGLE_PROMPT_STATE -eq 2 ]
        then
            PS1="$TOGGLE_PROMPT_PS1"
        fi
        # Inform user that the alternative PS1 has been set
        echo "Set TOGGLE_PROMPT_PS1 to \"$TOGGLE_PROMPT_PS1\"."
    # Else if any other argument is given, error
    elif [ ! -z "$1" ]
    then
        echo "Unknown command given." >&2
        return 1
    # Else if toggle from full PS1 to alternative PS1 is requested
    elif [ $__TOGGLE_PROMPT_STATE -eq 1 ]
    then
        # Update PS1 to alternative PS1
        PS1="$TOGGLE_PROMPT_PS1"
        # Update state
        __TOGGLE_PROMPT_STATE=2
    # Else if toggle from alternative PS1 to full PS1 is requested
    elif [ $__TOGGLE_PROMPT_STATE -eq 2 ]
    then
        # Update PS1 to full PS1
        PS1="$__TOGGLE_PROMPT_PS1_FULL"
        # Update state
        __TOGGLE_PROMPT_STATE=1
    # Else inform user of an unknown error to stderr
    else
        echo "Unknown error." >&2
        return 1
    fi
}
