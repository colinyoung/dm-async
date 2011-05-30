Gem::Specification.new do |s|
  s.name = "dm-async"
  s.version = "0.0.1"
  s.summary = %{An optionally-asynchronous special case for Ruby on Rails models, backed by DataMapper.}
  s.description = %Q{An optionally-asynchronous special case for Ruby on Rails models, backed by DataMapper.}
  s.authors = ["Colin Young"]
  s.email = ["me@colinyoung.com"]
  s.homepage = "http://github.com/colinyoung/dm-async"
  # s.rubyforge_project = "datamapper_async"
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.add_dependency 'dm-core',           '~> 1.1.0'
  s.add_dependency 'dm-serializer',     '~> 1.1.0'
  s.add_dependency 'dm-timestamps',     '~> 1.1.0'
  s.add_dependency "cutest", "~> 1.1"
  s.add_dependency "activesupport"
  s.add_dependency "event_machine"
end
