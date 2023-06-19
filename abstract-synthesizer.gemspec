# frozen_string_literal: true

lib = File.expand_path(%(lib), __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative %(./lib/abstract-synthesizer/version)

Gem::Specification.new do |spec|
  spec.name                  = %(abstract-synthesizer)
  spec.version               = AbstractSynthesizer::VERSION
  spec.authors               = [%(drzlnthslnt@gmail.com)]
  spec.email                 = [%(drzlnthslnt@gmail.com)]
  spec.description           = %(create resource based configuration DSL)
  spec.summary               = %(create resource based configuration DSL)
  spec.homepage              = %(https://github.com/drzln/#{spec.name})
  spec.license               = %(MIT)
  spec.files                 = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.require_paths         = [%(lib)]
  spec.required_ruby_version = %(>= #{`cat .ruby-version`})

  %i[
    rubocop-rspec
    rubocop-rake
    solargraph
    keycutter
    rubocop
    rspec
    rake
    yard
  ].each do |gem|
    spec.add_development_dependency(gem)
  end

  spec.metadata[%(rubygems_mfa_required)] = %(true)
end
