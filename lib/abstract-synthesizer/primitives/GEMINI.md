# lib/abstract-synthesizer/primitives/ Directory

This directory contains primitive modules or classes that provide fundamental functionalities used by the `abstract-synthesizer`.

- `bury.rb`: Defines the `Bury` module. This module extends the `Hash` class with a `bury` method. The `bury` method allows for nested assignment of values within a hash, creating intermediate hashes as needed. This is crucial for building the hierarchical `manifest` within the `AbstractSynthesizer`.