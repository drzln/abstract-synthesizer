# spec/ Directory

This directory contains the RSpec tests for the `abstract-synthesizer` gem. These tests ensure the correct functionality of the synthesizer, its factory, and the custom error handling.

- `spec_helper.rb`: This file sets up the testing environment. It requires the `abstract-synthesizer` gem and defines `RandoSynthesizer`, a test class that inherits from `AbstractSynthesizer` and overrides `method_missing` to use `abstract_method_missing` with a predefined set of keys (`:rando`). This allows for focused testing of the DSL behavior.
- `abstract_spec.rb`: Contains tests for the `AbstractSynthesizer` class. It verifies that the synthesizer can correctly compile small declarations into a hash, handles argument errors (e.g., `TooManyFieldValuesError`), and correctly assigns values to expected keys within the synthesized manifest.
- `factory_spec.rb`: Contains tests for the `SynthesizerFactory` module. It verifies that the factory can successfully create a resource synthesizer instance.