function envman --description 'Manage predefined environment variables'
    if test (count $argv) -lt 1
        echo "Usage: envman [set|unset|list|inspect] [VARIABLE_NAME]"
        return 1
    end
    
    set command $argv[1]
    
    switch $command
        case "set"
            if test (count $argv) -lt 2
                echo "Usage: envman set VARIABLE_NAME"
                echo "       envman set -a|--all"
                return 1
            end
            
            set var_name $argv[2]
            
            # Check for -a or --all flag to set all variables
            if test "$var_name" = "-a" -o "$var_name" = "--all"
                echo "Setting all predefined environment variables:"
                echo "-----------------"
                
                # Get all variables starting with env_vars_
                for var in (set -n | grep ^env_vars_)
                    set current_var_name (string replace env_vars_ "" $var)
                    set -gx $current_var_name $$var
                    echo "Set $current_var_name"
                end
                
                return 0
            end
            
            set config_var_name env_vars_$var_name
            
            if not set -q $config_var_name
                echo "Error: No predefined value found for $var_name"
                echo "Add it to ~/.config/fish/env_variables.fish first"
                return 1
            end
            
            # Get predefined value and set environment variable
            set -gx $var_name $$config_var_name
            echo "$var_name has been set"
            
        case "unset"
            if test (count $argv) -lt 2
                echo "Usage: envman unset VARIABLE_NAME"
                echo "       envman unset -a|--all"
                return 1
            end
            
            set var_name $argv[2]
            
            # Check for -a or --all flag to unset all variables
            if test "$var_name" = "-a" -o "$var_name" = "--all"
                echo "Unsetting all environment variables defined by envman:"
                echo "-----------------"
                
                # Get all variables starting with env_vars_
                for var in (set -n | grep ^env_vars_)
                    set current_var_name (string replace env_vars_ "" $var)
                    
                    if set -q $current_var_name
                        set -e $current_var_name
                        echo "Removed $current_var_name"
                    end
                end
                
                return 0
            end
            
            if not set -q $var_name
                echo "Warning: $var_name is not currently set"
                return 0
            end
            
            set -e $var_name
            echo "$var_name has been removed"
            
        case "list"
            echo "Predefined environment variables:"
            echo "-----------------"
            
            # Get all variables starting with env_vars_
            for var in (set -n | grep ^env_vars_)
                set var_name (string replace env_vars_ "" $var)
                echo "$var_name"
            end
            
        case "inspect"
            if test (count $argv) -lt 2
                echo "Usage: envman inspect VARIABLE_NAME"
                echo "       envman inspect -a|--all"
                return 1
            end
            
            set var_name $argv[2]
            
            # Check for -a or --all flag to inspect all variables
            if test "$var_name" = "-a" -o "$var_name" = "--all"
                echo "Currently set environment variables:"
                echo "-----------------"
                
                # Get all variables starting with env_vars_
                for var in (set -n | grep ^env_vars_)
                    set current_var_name (string replace env_vars_ "" $var)
                    
                    if set -q $current_var_name
                        set var_value $$current_var_name
                        # Show first few and last few characters of the value
                        set value_length (string length "$var_value")
                        if test $value_length -gt 30
                            set prefix (string sub -l 10 "$var_value")
                            set suffix (string sub -s (math $value_length - 5 + 1) "$var_value")
                            echo "$current_var_name: $prefix...$suffix (length: $value_length)"
                        else
                            echo "$current_var_name: $var_value"
                        end
                    end
                end
                
                return 0
            end
            
            if not set -q $var_name
                echo "Warning: $var_name is not currently set"
                set config_var_name env_vars_$var_name
                if set -q $config_var_name
                    echo "A predefined value exists but is not currently set"
                    echo "Use 'envman set $var_name' to set it"
                end
                return 0
            end
            
            set var_value $$var_name
            echo "$var_name: $var_value"
            
        case '*'
            echo "Unknown command: $command"
            echo "Usage: envman [set|unset|list|inspect] [VARIABLE_NAME]"
            return 1
    end
end
