require_relative "lib/odeio_front_end/version"

Gem::Specification.new do |spec|
  spec.name = "odeio_front_end"
  spec.version = OdeioFrontEnd::VERSION
  spec.authors = [ "Jao-Dev" ]
  spec.email = [ "jpl71330@gmail.com" ]
  spec.summary = "Componentes de front end reutilizáveis para os projetos pessoais do Jao."
  spec.description = "Gem de layout no estilo UENF Layout: card, alert, btn, badge, table, " \
                     "empty e links padronizados (ver/editar/novo/excluir) sobre Tabler/Bootstrap."
  spec.homepage = "https://github.com/Jao-Dev/odeio_front_end"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,lib}/**/*", "Rakefile", "README.md", "CHANGELOG.md"]
  end

  spec.add_dependency "haml"
  spec.add_dependency "rails", ">= 7.2"
  spec.add_dependency "view_component"
end
