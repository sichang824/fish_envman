# Envman - Environment Variable Manager for Fish Shell

Envman is a simple utility for managing predefined environment variables in the Fish shell.

## Features

- Set predefined environment variables quickly
- Unset environment variables
- List all available predefined variables
- Inspect the current values of environment variables
- Set all predefined variables at once
- Tab completion support

## Installation

You can install envman using the provided Makefile:

```
cd ~/Workspace/fish_envman
make install
```

This will copy the necessary files to your Fish configuration directory.

## Usage

### List available variables

```
envman list
```

### Set a single variable

```
envman set VARIABLE_NAME
```

### Set all predefined variables

```
envman set -a
# or
envman set --all
```

### Unset a variable

```
envman unset VARIABLE_NAME
```

### Unset all variables

```
envman unset -a
# or
envman unset --all
```

### Inspect a variable's value

```
envman inspect VARIABLE_NAME
```

### Inspect all set variables

```
envman inspect -a
# or
envman inspect --all
```

## Configuration

Add your predefined variables to `~/.config/fish/conf.d/env_variables.fish` in the following format:

```fish
set env_vars_VARIABLE_NAME value
```

For example:
```fish
set env_vars_API_KEY your_api_key_here
```

## Uninstallation

```
cd ~/Workspace/fish_envman
make uninstall
```
