Gem::Specification.new do |gem|
  gem.name        = 'billit_representers'
  gem.version     = '0.0.0'
  gem.date        = '2013-03-28'
  gem.summary     = "Representers for the bill-it module of the Poplus project."
  gem.description = "Representers for the bill-it module of the Poplus project. These provide object-like access to remote data, using Resource-Oriented Architectures in Ruby (ROAR)."
  gem.authors     = ["Marcel Augsburger"]
  gem.email       = 'devteam@ciudadanointeligente.org'
  gem.homepage    = 'https://github.com/ciudadanointeligente/billit_representers'

  gem.add_runtime_dependency "roar"
end
