Gem::Specification.new do |s|
  s.name        = 'beta_code'
  s.version     = '0.0.3'
  s.date        = '2017-07-07'
  s.summary     = 'Converts Greek beta code to Greek characters and vice versa'
  s.description = 'Converts Greek beta code to Greek characters and vice versa'
  s.authors     = ['zfletch']
  s.email       = 'zfletch2@gmail.com'
  s.files       = ['lib/beta_code.rb'] + Dir['vendor/**/*']
  s.homepage    = 'https://github.com/zfletch/beta-code-rb'
  s.license     = 'MIT'

  s.add_development_dependency 'test-unit', '~> 3.2'
end
