# frozen_string_literal: true

require %(bundler/gem_tasks)
require %(rubocop/rake_task)
require %(rspec/core/rake_task)
require %(erb)

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = [%(--display-cop-names)]
end
