# GToolkit-Boxer ![](https://github.com/feenkcom/gtoolkit-boxer/workflows/Cargo%20Build/badge.svg)
A set of utilities to work with Rust through ffi

## Installation

```smalltalk 
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkitBoxer';
    repository: 'github://feenkcom/gtoolkit-boxer/boxer-bindings';
    load
] ensure: [ EpMonitor current enable ].  
```
