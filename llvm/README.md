# llvm

Core components of the LLVM toolchain

## llvm

Currently provides `llvm`, `compiler-rt` and `clang`. Will be stripped down to just `llvm`
with the compiler components split out into a separate package. Will also become versioned.

## libcxx

Provides `libcxx` / `libcxxabi`, we do not use `libstdc++` by default.

## lldb

Debugger.

## llvm-bolt

Binary Optimistion + Layout Tool (better linking)