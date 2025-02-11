## Kernel packaging

As with any package, update your `stone.yaml` to point to the latest tarball.
It is recommended you keep it somewhere local:


### Prepare the kernel tree

```bash
# Enter the directory of the kernel version you want to work on
cd l/linux-<kernel version>/

# Set up a work directory
mkdir -pv work
cd work

# Fetch the tarball of the kernel you want to work on. Use the URL from the stone.yaml
# recipe if you want to patch or adjust the config of the upstream kernel at the version
# that Serpent OS currently ships
wget <the linux kernel you want to work on>

# Unpack the tarball
tar xf linux*.tar.*

# Check that the shasum is good
sha256sum linux*.tar.*
```

At this point, the kernel is ready to be configured inside a serpent-based systemd-nspawn root.


### Update the kernel config

Firstly, enter the nspawn environment which will be populated using moss ephemeral roots
for up to date build dependencies, allowing native configuration:

```bash
# Go back to the root of the serpent linux-<kernel version>/ recipe dir
cd ../..

# This should drop you into the /kernel dir as the root user inside the systemd-nspawn container
just nspawn

# Go into the working directory with the extracted kernel sources:
cd work/linux*

# Make sure you also apply and rebase any patches from `the /kernel/pkg/` directory!
# -- git is available, so you can use `git apply` for this
git apply ../../pkg/(...)

# Ensure that you use the existing serpent kernel config as the starting point:
cp ../../pkg/config-x86_64 .config

# Update the existing kernel config to the new kernel version as your new starting point:
make CC=clang ARCH=x86_64 LLVM=1 LD=ld.lld LLVM_IAS=1 WERROR=0 oldconfig

# Make any adjustments you would like to make
make CC=clang ARCH=x86_64 LLVM=1 LD=ld.lld LLVM_IAS=1 WERROR=0 menuconfig

# Ensure you save your new work/linux-(..)/.config file back to the serpent pkg/ dir
cp .config ../../pkg/config-x86_64

# Exit the nspawn container
exit
```

After you exit the nspawn container environment and are back to your original session,
you can edit the `stone.yaml` recipe to use the new upstream version (along with any new
patches you have added) with `just build`.

Best of luck on your kernel maintenance journey. ^^'
