# lib/ Directory

This directory contains the main source code for the `abstract-synthesizer` gem.

- `abstract-synthesizer.rb`: This is the primary entry point for the gem. It defines the `AbstractSynthesizer` class and the `SynthesizerFactory` module.

## AbstractSynthesizer Class

The `AbstractSynthesizer` class is designed to create a resource-based configuration DSL (Domain Specific Language). It allows users to define hierarchical data structures (manifests) using a Ruby-like syntax.

Key features and methods:
- `initialize`: Initializes the synthesizer with a `translation` hash, which stores the `ancestors` (current path in the manifest), `manifest` (the generated data structure), and `context`.
- `clear!`: Resets the `manifest`.
- `synthesis`: Returns the generated `manifest`.
- `synthesize(content = nil, &block)`: Evaluates the provided content or block to build the manifest. This is where the DSL is processed.
- `manifest`: An alias for `synthesis`.
- `valid_method?(method, keys)`: Internal method to check if a method call is valid within the current context (resource definition or field assignment).
- `validate_method(method, keys)`: Raises `InvalidSynthesizerKeyError` if a method is not valid.
- `validate_args(args)`: Validates the number of arguments based on the current context, raising `TooManyFieldValuesError`.
- `abstract_method_missing(method, keys, *args)`: This is the core of the DSL. It dynamically handles method calls, interpreting them as resource keys or field assignments, and building the `translation[:manifest]` accordingly. It uses the `Bury` module for nested data insertion.

## SynthesizerFactory Module

This module provides a factory method to create instances of `AbstractSynthesizer`.

- `create_synthesizer(name:, keys:)`: Creates a new `AbstractSynthesizer` instance and dynamically defines its `method_missing` method. This `method_missing` delegates to `abstract_method_missing` within the `AbstractSynthesizer` instance, passing the allowed `keys` for the DSL. This allows for flexible definition of the DSL structure based on the provided `keys`.