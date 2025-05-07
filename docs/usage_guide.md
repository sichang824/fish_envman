# Envman Usage Guide

This guide provides detailed examples of how to use the Envman tool for managing environment variables in Fish shell.

## Setting Up Predefined Variables

Before using Envman, you need to set up your predefined environment variables. Edit or create the `env_variables.fish` file:

```
vim ~/.config/fish/conf.d/env_variables.fish
```

Add your variables in the following format:

```fish
set env_vars_VARIABLE_NAME value
```

Example:
```fish
set env_vars_API_KEY your_api_key_here
set env_vars_DATABASE_URL mysql://user:pass@localhost:3306/dbname
set env_vars_AWS_REGION us-west-2
```

## Basic Commands

### Listing Available Variables

To see all predefined variables available:

```fish
envman list
```

Output:
```
Predefined environment variables:
-----------------
API_KEY
DATABASE_URL
AWS_REGION
```

### Setting a Variable

To set a specific environment variable:

```fish
envman set API_KEY
```

Output:
```
API_KEY has been set
```

You can verify the variable has been set:

```fish
echo $API_KEY
```

### Setting All Variables

To set all predefined variables at once:

```fish
envman set -a
```

or

```fish
envman set --all
```

Output:
```
Setting all predefined environment variables:
-----------------
Set API_KEY
Set DATABASE_URL
Set AWS_REGION
```

### Inspecting Variables

To view the current value of a variable:

```fish
envman inspect API_KEY
```

Output:
```
API_KEY: your_api_key_here
```

For longer values like tokens, the output will show a truncated version:

```fish
envman inspect LONG_TOKEN
```

Output:
```
LONG_TOKEN: ab12cd34...xy89z (length: 64)
```

To inspect all currently set variables:

```fish
envman inspect -a
```

or 

```fish
envman inspect --all
```

Output:
```
Currently set environment variables:
-----------------
API_KEY: your_api_key_here
DATABASE_URL: mysql://user:pass@localhost:3306/dbname
LONG_TOKEN: ab12cd34...xy89z (length: 64)
```

### Unsetting a Variable

To unset a specific environment variable:

```fish
envman unset API_KEY
```

Output:
```
API_KEY has been removed
```

### Unsetting All Variables

To unset all variables that were set using Envman:

```fish
envman unset -a
```

or

```fish
envman unset --all
```

Output:
```
Unsetting all environment variables defined by envman:
-----------------
Removed API_KEY
Removed DATABASE_URL
Removed AWS_REGION
```

## Tips and Best Practices

1. **Sensitive Information**: For sensitive information like API keys, consider using encrypted storage solutions and only set these variables when needed.

2. **Project-Specific Variables**: You can create separate files for different projects:
   ```fish
   set env_vars_PROJECT1_API_KEY value1
   set env_vars_PROJECT2_API_KEY value2
   ```

3. **Temporary Usage**: If you need the variables only for a single command, you can combine setting and using in one line:
   ```fish
   envman set API_KEY; and curl -H "Authorization: Bearer $API_KEY" https://api.example.com
   ```

4. **Shell Sessions**: Remember that environment variables are only available in the current shell session. If you open a new terminal, you'll need to set them again.

5. **Security Best Practice**: When done with sensitive variables, always unset them:
   ```fish
   # Use the variable
   envman set API_KEY
   curl -H "Authorization: Bearer $API_KEY" https://api.example.com
   
   # Then unset when finished
   envman unset API_KEY
   ```
