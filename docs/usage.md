# Usage Guide

This guide explains how to use the `abstract-synthesizer` gem to define resource-based configurations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'abstract-synthesizer'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install abstract-synthesizer
```

## Basic Usage

To use the synthesizer, you typically create an instance using the `SynthesizerFactory` and then define your configuration within a `synthesize` block.

```ruby
require 'abstract-synthesizer'

# Define the allowed keys for your DSL
# These keys will be the valid methods you can call in your DSL block
resource_keys = %i[server database user]

synthesizer = SynthesizerFactory.create_synthesizer(name: :my_config, keys: resource_keys)

synthesizer.synthesize do
  server :web_server, :production do
    host 'example.com'
    port 8080
    ssl true
  end

  server :api_server, :development do
    host 'localhost'
    port 3000
  end

  database :main_db, :mysql do
    username 'admin'
    password 'secret'
    host 'db.example.com'
  end

  user :admin_user do
    name 'Administrator'
    email 'admin@example.com'
  end
end

# Access the generated manifest
puts synthesizer.synthesis.inspect
# Expected Output (simplified):
# {
#   :server => {
#     :web_server => {
#       :production => {
#         :host => "example.com", :port => 8080, :ssl => true
#       }
#     },
#     :api_server => {
#       :development => {
#         :host => "localhost", :port => 3000
#       }
#     }
#   },
#   :database => {
#     :main_db => {
#       :mysql => {
#         :username => "admin", :password => "secret", :host => "db.example.com"
#       }
#     }
#   },
#   :user => {
#     :admin_user => {
#       :name => "Administrator", :email => "admin@example.com"
#     }
#   }
# }
```

## DSL Structure

The DSL follows a hierarchical structure:

- **Resource Definition**: The top-level methods in your `synthesize` block correspond to the `keys` you provided to `create_synthesizer`. These methods can take multiple arguments, which become nested keys in the manifest.
  ```ruby
  resource_key :first_level_identifier, :second_level_identifier do
    # ... fields or nested resources
  end
  ```

- **Field Assignment**: Inside a resource block, methods without a block are treated as field assignments. They take a single argument, which is the value for that field.
  ```ruby
  field_name 'field_value'
  another_field 123
  ```

## Error Handling

The gem provides specific error classes for common issues:

- `InvalidSynthesizerKeyError`: Raised when you try to use a method in your DSL that was not included in the `keys` provided to `SynthesizerFactory.create_synthesizer`.
- `TooManyFieldValuesError`: Raised when a field assignment method receives more than one argument.
- `NotEnoughResourceKeys`: Raised when a resource definition does not receive the expected number of arguments (e.g., if a top-level resource expects two identifiers but only one is provided).
