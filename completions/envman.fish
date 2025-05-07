# Completion definitions

# Main command completions
complete -c envman -f -n "not __fish_seen_subcommand_from set unset list inspect" -a "set" -d "Set a predefined environment variable"
complete -c envman -f -n "not __fish_seen_subcommand_from set unset list inspect" -a "unset" -d "Remove a set environment variable"
complete -c envman -f -n "not __fish_seen_subcommand_from set unset list inspect" -a "list" -d "List all predefined environment variables"
complete -c envman -f -n "not __fish_seen_subcommand_from set unset list inspect" -a "inspect" -d "Show the current value of environment variables"

# Completions for the set subcommand
function __envman_variables
    # Get predefined environment variables
    for var in (set -n | grep ^env_vars_)
        set var_name (string replace env_vars_ "" $var)
        echo $var_name\\t"Value: $$var"
    end
end

# Provide variable name completions for set, unset, and inspect commands
complete -c envman -f -n "__fish_seen_subcommand_from set" -a "(__envman_variables)"
complete -c envman -f -n "__fish_seen_subcommand_from set" -a "-a --all" -d "Set all predefined variables"
complete -c envman -f -n "__fish_seen_subcommand_from unset" -a "(set -n | grep -v '^_' | grep -v '^fish_')"
complete -c envman -f -n "__fish_seen_subcommand_from unset" -a "-a --all" -d "Unset all variables"
complete -c envman -f -n "__fish_seen_subcommand_from inspect" -a "(set -n | grep -v '^_' | grep -v '^fish_')"
complete -c envman -f -n "__fish_seen_subcommand_from inspect" -a "-a --all" -d "Inspect all set variables"
