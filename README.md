# Abstract Synthesizer

[![Gem Version](https://badge.fury.io/rb/abstract-synthesizer.svg)](https://badge.fury.io/rb/abstract-synthesizer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Ruby gem for creating resource-based configuration DSLs. Abstract Synthesizer allows you to define custom domain-specific languages for configuration management with a clean, hierarchical syntax.

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

## Quick Start

```ruby
require 'abstract-synthesizer'

# Define allowed resource keys for your DSL
resource_keys = %i[server database user]

# Create a synthesizer instance
synthesizer = SynthesizerFactory.create_synthesizer(name: :my_config, keys: resource_keys)

# Use the DSL to define your configuration
synthesizer.synthesize do
  server :web_server, :production do
    host 'example.com'
    port 8080
    ssl true
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

# Access the generated configuration
puts synthesizer.synthesis
# => {
#   :server => {
#     :web_server => {
#       :production => {
#         :host => "example.com", :port => 8080, :ssl => true
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

## How It Works

### 1. Resource Definition
Resources are top-level methods in your `synthesize` block that correspond to the `keys` you provided. They can accept multiple arguments which become nested keys:

```ruby
resource_key :first_level_identifier, :second_level_identifier do
  # ... fields or nested configuration
end
```

### 2. Field Assignment
Inside resource blocks, methods without blocks are treated as field assignments:

```ruby
field_name 'field_value'
another_field 123
boolean_field true
```

### 3. Hierarchical Nesting
The gem automatically creates a nested hash structure based on your DSL usage:

```ruby
synthesizer.synthesize do
  server :api, :development do
    host 'localhost'
    port 3000
    
    # Nested configuration is supported
    ssl_config do
      enabled false
      cert_path nil
    end
  end
end
```

## Error Handling

Abstract Synthesizer provides specific error classes:

- `InvalidSynthesizerKeyError`: Raised when using undefined resource keys
- `TooManyFieldValuesError`: Raised when field assignments receive multiple arguments

```ruby
# This will raise InvalidSynthesizerKeyError
synthesizer.synthesize do
  invalid_resource do  # 'invalid_resource' not in keys
    field 'value'
  end
end

# This will raise TooManyFieldValuesError  
synthesizer.synthesize do
  server :web do
    port 8080, 3000  # Fields can only accept one value
  end
end
```

## Use Cases

- **Configuration Management**: Define application configurations with validation
- **Infrastructure as Code**: Create DSLs for server and service definitions
- **Build Scripts**: Generate complex build configurations
- **API Definitions**: Structure API endpoint and middleware configurations

## Documentation

For detailed usage examples and advanced features, see the [documentation](docs/).

## Development

After checking out the repo, run:

```bash
bundle install
```

To run tests:

```bash
bundle exec rspec
```

To run linting:

```bash
bundle exec rubocop
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
