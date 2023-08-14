if not type -q silver
    echo -e '\e[91msilver is not installed; please follow the instructions on https://github.com/reujab/silver#installation\e[m' >/dev/stderr
    exit 1
end
function fish_prompt
    env code=$status jobs=(count (jobs -p)) cmdtime={$CMD_DURATION} silver lprint
end
function fish_right_prompt
    env code=$status jobs=(count (jobs -p)) cmdtime={$CMD_DURATION} silver rprint
end
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
