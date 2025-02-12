# frozen_string_literal: true

lib = File.expand_path(%(lib), __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative %(./lib/abstract-synthesizer/version)

Gem::Specification.new do |spec|
  spec.name                  = %(abstract-synthesizer)
  spec.version               = AbstractSynthesizer::VERSION
  spec.authors               = [%(drzzln@protonmail.com)]
  spec.email                 = [%(drzzln@protonmail.com)]
  spec.description           = %(create resource based configuration DSL)
  spec.summary               = %(create resource based configuration DSL)
  spec.homepage              = %(https://github.com/drzln/#{spec.name})
  spec.license               = %(MIT)
  spec.files                 = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.require_paths         = [%(lib)]
  spec.required_ruby_version = %(3.6.6)

  definition = Bundler::Definition.build("Gemfile", "Gemfile.lock", nil)
  runtime_deps = definition.dependencies.select { |dep| dep.groups.include?(:default) }
  runtime_deps.each do |dep|
    spec.add_dependency(dep.name, *dep.requirement.as_list)
  end
end
