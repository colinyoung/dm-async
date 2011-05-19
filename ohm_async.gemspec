Gem::Specification.new do |s|
  s.name = "ohm_async"
  s.version = "0.0.1"
  s.summary = %{An optionally-asynchronous special case for Ruby on Rails models, backed by Ohm, an ORM for Redis.}
  s.description = %Q{An optionally-asynchronous special case for Ruby on Rails models, backed by Ohm, an ORM for Redis.}
  s.authors = ["Colin Young"]
  s.email = ["me@colinyoung.com"]
  s.homepage = "http://github.com/colinyoung/ohm_async"
  # s.files = ["lib/ohm/compat-1.8.6.rb", "lib/ohm/key.rb", "lib/ohm/pattern.rb", "lib/ohm/utils/upgrade.rb", "lib/ohm/validations.rb", "lib/ohm/version.rb", "lib/ohm.rb", "README.markdown", "LICENSE", "Rakefile", "test/1.8.6_test.rb", "test/associations_test.rb", "test/connection_test.rb", "test/errors_test.rb", "test/hash_key_test.rb", "test/helper.rb", "test/indices_test.rb", "test/json_test.rb", "test/model_test.rb", "test/mutex_test.rb", "test/pattern_test.rb", "test/upgrade_script_test.rb", "test/validations_test.rb", "test/wrapper_test.rb", "test/test.conf"]
  # s.rubyforge_project = "ohm_async"
  s.add_dependency "ohm", "~> 0.1.3"
  s.add_dependency "cutest", "~> 1.1"
  s.add_dependency "active_support"
end
