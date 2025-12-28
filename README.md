# Network File Server

This repo contains the interface for the client (`fs_client.h`). It also has the interface for the server, which runs on my implementation of a multi-threaded network file server in C++20. Disk abstraction is provided by the course infrastructure, although the disk objects themselves can be accessed with `showfs`. Peek at `testsample.cpp` for a demonostration of the basic features.

## Verified Environments
macOS (Apple Silicon M1+) with Clang 14+, Boost 1.89+
 
Red Hat Enterprise Linux (RHEL 9) with GCC 12+, Boost 1.89+

## Characteristics and Features
- Hierarchical file system with user-owned files and directories
- Supports file read/write/create/delete and directory create/delete
- Guarantees crash-consistency with carefully-ordered, committed disk-writes
- Guarantees thread-safety and optimizes concurrency with Boost threads and reader/writer locks
- Handles untrusted client input robustly with proper request sanitation

## Example Usage
Create a fresh file system.
`./tools/create_fs` (Linux) `./tools/createfs_macos` (macOS)

Run file server on port 67 on localhost.

`./build/fs 67` (Linux) `./build/fs_macos 67` (macOS)

In a separate terminal window, build an executable that connects to the file server (in this case, `testsample.cpp`) and run it with the specified port and address.

`make testsample && ./testsample localhost 67` 

View the file system (not thread-safe)

`./tools/showfs` (Linux) `./tools/showfs_macos` (macOS)