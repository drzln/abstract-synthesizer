# lib/abstract-synthesizer/errors/ Directory

This directory contains custom error classes used by the `abstract-synthesizer` gem. These errors are raised when specific conditions are not met during the synthesis process, providing clear feedback to the user.

- `invalid_synthesizer_key_error.rb`: Defines `InvalidSynthesizerKeyError`. This error is raised when the synthesizer attempts to process a key (method call) that is not defined or recognized as a valid resource key within the DSL.

- `too_many_field_values.rb`: Defines `TooManyFieldValuesError`. This error is raised when too many field values are provided for a given field, indicating an incorrect usage of the DSL.