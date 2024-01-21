## Kernel packaging

As with any package, update your `stone.yml` to point to the latest tarball.
It is recommended you keep it somewhere local:


```bash
mkdir work
cd work
wget http...
tar xf linux*.tar.*
sha256sum linux*.tar.*
```

## Updating the kernel config

Firstly, enter the nspawn environment which will be populated using moss ephemeral roots
for up to date build dependencies, allowing native configuration:


```bash
$ just nspawn
$ cd work/linux*
$ cp ../../pkg/config-x86_64 .config
$ make CC=clang ARCH=x86_64 LLVM=1 WERROR=0 oldconfig
```

Make sure you also apply and rebase any patches from `pkg`.