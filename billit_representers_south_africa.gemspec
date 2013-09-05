Gem::Specification.new do |gem|
  gem.name        = 'billit_representers_south_africa'
  gem.version     = '0.0.0'
  gem.date        = '2013-09-09'
  gem.summary     = "Representers for the South African deploy of the bill-it module. Part of the Poplus project."
  gem.description = "Representers for the South African deploy of the bill-it module. Part of the Poplus project. These Provide object-like access to South African bill data, using Resource-Oriented Architectures in Ruby (ROAR)."
  gem.authors     = ["Marcel Augsburger"]
  gem.email       = 'devteam@ciudadanointeligente.org'
  gem.homepage    = 'https://github.com/ciudadanointeligente/billit_representers/tree/south_africa'
  gem.license     = 'GPL-3'

  gem.files       = `git ls-files`.split("\n")

  gem.add_runtime_dependency "roar"
  gem.add_runtime_dependency "activemodel"
end
