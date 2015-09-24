Gem::Specification.new do |gem|
  gem.name = 'gitignore_rb'
  gem.version = '0.2.4'
  gem.homepage = 'https://github.com/nathankleyn/gitignore.rb'
  gem.license = 'MIT'

  gem.author = 'Nathan Kleyn'
  gem.email = 'nathan@nathankleyn.com'
  gem.summary = 'A Ruby binding around gitignore.rs, a Rust implementation of .gitignore file parsing and glob testing.'
  gem.description = "See #{gem.homepage} for more information!"

  # Uncomment this if you plan on having an executable instead of a library.
  # gem.executables << 'your_wonderful_gem'
  gem.files = Dir['**/*'].select { |d| d =~ %r{^(README.md|bin/|ext/(?!.*target)|lib/)} }

  # We use the trick of a Rakefile rather than an extconf.rb file as outlined in
  # http://yorickpeterse.com/articles/hacking-extconf-rb/.
  gem.extensions = %w(ext/gitignore_binding/Rakefile)

  # Add your dependencies here as follows:
  #
  #   gem.add_dependency 'some-gem', '~> 1.0'
  gem.add_dependency 'ffi', '~> 1.9'

  # Add your test dependencies here as follows:
  #
  #   gem.add_development_dependency 'whatever', '~> 1.0'
  #
  # Some sane defaults follow.
  gem.add_development_dependency 'coveralls', '~> 0.8'
  gem.add_development_dependency 'filewatcher', '~> 0.5'
  gem.add_development_dependency 'pry-byebug', '~> 3.2'
  gem.add_development_dependency 'rspec', '~> 3.3'
  gem.add_development_dependency 'rubocop', '~> 0.34'
  gem.add_development_dependency 'rubocop-rspec', '~> 1.3'
end
