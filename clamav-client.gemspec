# coding: utf-8
$:<< 'lib'

Gem::Specification.new do |spec|
  spec.name          = "clamav-client"
  spec.version       = "3.4.2"
  spec.authors       = ["Franck Verrot"]
  spec.email         = ["franck@verrot.fr"]
  spec.summary       = %q{ClamAV::Client connects to a Clam Anti-Virus clam daemon and send commands.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/franckverrot/clamav-client"
  spec.license       = "GPL-v3"
  spec.required_ruby_version = '>= 2.5'

  spec.files = Dir['{lib,test}/**/*', 'LICENSE.txt', 'ChangeLog.md', 'Rakefile', 'README.md', 'Gemfile', 'clamav-client.gemspec'].reject { |f| f['test/fixtures'] }

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
end
