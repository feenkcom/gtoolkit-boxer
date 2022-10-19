# GToolkit-Boxer
A set of utilities to work with Rust through ffi

## Building the shared library

```bash
cargo build --package libboxer --release
```

## Installation

Place the shared library (`target/release/libBoxer.dylib`) in the shared libraries folder of the Pharo VM or near the `.image`.
Install the bindings:

```smalltalk 
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkitBoxerBindings';
    repository: 'github://feenkcom/gtoolkit-boxer:main/boxer-bindings';
    load
] ensure: [ EpMonitor current enable ].  
```
