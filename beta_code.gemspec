Gem::Specification.new do |s|
  s.name        = 'beta_code'
  s.version     = '0.0.9'
  s.date        = '2018-02-17'
  s.summary     = 'Converts Greek beta code to Greek characters and vice versa'
  s.description = 'This is a gem that converts from Ancient Greek beta code to Unicode characters and vice versa'
  s.authors     = ['perseids']
  s.email       = 'perseids@tufts.edu'
  s.files       = ['lib/beta_code.rb'] + Dir['vendor/**/*']
  s.homepage    = 'https://github.com/perseids-tools/beta-code-rb'
  s.license     = 'MIT'

  s.add_development_dependency 'test-unit', '~> 3.2'
end
