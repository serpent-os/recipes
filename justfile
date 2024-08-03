default: (_build build_file)

set dotenv-load
# respect BOULDER=<...> and BOULDER_ARGS=<...> set in .env file next to the present justfile
boulder := env_var_or_default('BOULDER', 'boulder')
boulder_args := env_var_or_default('BOULDER_ARGS', '')
boulder_profile := env_var_or_default('BOULDER_PROFILE', 'local-x86_64')
build_file := join(invocation_directory(), "stone.yaml")

# Build the stone.yaml recipe using boulder
_build target:
    cd {{ invocation_directory() }}; {{boulder}} {{boulder_args}} build -u {{ if path_exists(target) == "true" { target } else { error("Missing stone.yaml file") } }} -p {{ boulder_profile }}

# Build stone.yaml from the current directory
build: (_build build_file)

# Chroot into target from stone.yaml recipe with boulder
_chroot target:
    cd {{ invocation_directory() }}; {{boulder}} {{boulder_args}} chroot {{ if path_exists(target) == "true" { target } else { error("Missing stone.yaml file") } }}

# Chroot into pkg from the current directory
chroot: (_chroot build_file)

# Clean up .stone files
_clean target:
    cd {{ invocation_directory() }}; rm -v *.stone || echo "No .stone file(s) found"

# Clean *.stone artefacts from the current directory
clean: (_clean build_file)
