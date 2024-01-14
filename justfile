default: (_build build_file)

build_profile := env_var_or_default('BOULDER_PROFILE', 'local-x86_64')
build_file := join(invocation_directory(), "stone.yml")

# Build the stone.yml recipe using boulder
_build target:
    cd {{ invocation_directory() }}; sudo boulder bi {{ if path_exists(target) == "true" { target } else { error("Missing stone.yml file") } }} -p {{ build_profile }}

# Build stone.yml from the current directory
build: (_build build_file)
