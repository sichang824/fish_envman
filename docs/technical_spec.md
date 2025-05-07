# Envman Technical Specification

## Overview

Envman is a Fish shell utility for managing predefined environment variables. It provides a simple interface to set, unset, and list environment variables based on predefined values.

## Components

### Main Function (`envman.fish`)

The core functionality is implemented in the `envman` function with three primary commands:

1. **set** - Sets environment variables based on predefined values
2. **unset** - Removes environment variables
3. **list** - Lists all available predefined variables

### Configuration (`env_variables.fish`)

The configuration file stores predefined variable values in the format:
```fish
set env_vars_VARIABLE_NAME value
```

### Completions (`completions/envman.fish`)

Provides tab completion support for the `envman` command, including:
- Command completion (set, unset, list)
- Variable name completion based on predefined variables

## Implementation Details

### Variable Naming Convention

- Predefined variables: `env_vars_VARIABLE_NAME`
- Actual environment variables: `VARIABLE_NAME`

### Command: `set`

- Usage: `envman set VARIABLE_NAME` or `envman set -a|--all`
- Function:
  - For a specific variable: Sets the environment variable `VARIABLE_NAME` to the value stored in `env_vars_VARIABLE_NAME`
  - For `-a|--all`: Sets all defined environment variables

### Command: `unset`

- Usage: `envman unset VARIABLE_NAME` or `envman unset -a|--all`
- Function:
  - For a specific variable: Removes the environment variable `VARIABLE_NAME`
  - For `-a|--all`: Removes all environment variables that were defined by envman

### Command: `list`

- Usage: `envman list`
- Function: Lists all available predefined variables (without their values)

## File Structure

```
fish_envman/
├── functions/
│   └── envman.fish         # Main function implementation
├── completions/
│   └── envman.fish         # Tab completion support
├── conf.d/
│   └── env_variables.fish  # Predefined variables configuration
├── docs/                   # Documentation
│   ├── README.md
│   ├── usage_guide.md
│   └── technical_spec.md
└── Makefile               # Installation and management
```

## Performance Considerations

- Variable lookup is performed using Fish's built-in variable system
- No external dependencies or commands are required
- Minimal overhead for setting/unsetting variables

## Security Considerations

- Sensitive information is stored in the Fish configuration directory
- No encryption is provided by the tool itself
- Users should ensure proper file permissions for the configuration files

## Future Enhancements

Potential improvements for future versions:

1. Variable value encryption for sensitive data
2. Project-specific variable sets
3. Export/import functionality
4. Support for temporary variables (session-only)
5. Default values for optional variables
