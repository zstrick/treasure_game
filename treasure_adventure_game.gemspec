Gem::Specification.new do |s|
  s.name         = "treasure_adventure_game"
  s.version      = "1.0.0"
  s.author       = "Zack Strickland"
  s.email        = "zack.a.strickland@gmail.com"
  s.summary      = "A fun treasure game."
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README.md)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'treasure_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
