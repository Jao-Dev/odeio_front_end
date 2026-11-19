# odeio_front_end

Gem de layout para os projetos pessoais:
componentes ViewComponent sobre Tabler/Bootstrap, registrados como helpers de view.

O objetivo é parar de copiar/colar front end a cada projeto: a gem fornece
`card`, `alert`, `btn`, `badge`, `table`, `empty` e links padronizados
(`link_show`, `link_edit`, `link_new`, `link_destroy`) em um único lugar.

## Instalação

No `Gemfile` do projeto:

```ruby
gem "odeio_front_end", github: "Jao-Dev/odeio_front_end"
```

No `ApplicationController`, inclua os helpers:

```ruby
class ApplicationController < ActionController::Base
  helper OdeioFrontEnd::ApplicationHelper
end
```

CSS/JS do Tabler continuam por conta do app (como hoje: CDN ou npm).

## Uso

```haml
= card 'Personagens', actions: [ btn('Nova personagem', new_path) ] do
  - if personagens.any?
    = table headers: ['Nome', 'Raça'] do
      - personagens.each do |p|
        %tr
          %td= p.name
          %td= p.race
  - else
    = empty 'Nenhuma personagem.'
```

Links padronizados (o texto e o estilo vêm da gem):

```haml
= link_show character_path(p)     # 'Ver', btn-info
= link_edit edit_character_path(p) # 'Editar', btn-warning
= link_new new_character_path      # 'Novo', btn-primary
= link_destroy character_path(p)   # 'Excluir', btn-danger, DELETE com confirm
```

Todos os helpers de botão/link aceitam `auth:` — quando `false`, o botão não
renderiza (útil para Pundit: `link_edit(path, auth: policy(p).update?)`).

`btn` aceita `style:`, `size: :small`, `method:`, `confirm:` e `auth:`
(ao contrário do `ui_helper` antigo do ficha_rpg, o botão é normal por padrão —
`btn-sm` só quando `size: :small`).

## Desenvolvimento

```bash
bundle install
bundle exec rspec    # specs com app dummy em spec/dummy
bundle exec rubocop
```

Os specs testam os componentes isolados (`render_inline`) e as views do app
dummy via request specs — é ali que o registro de helpers (`ComponentRegister`)
é exercitado de verdade, como um app host faria.

## Adicionando um componente novo

1. Crie `app/components/odeio_front_end/meu_componente.rb` (+ template `.html.haml` se precisar).
2. Adicione `:meu` à lista `COMPONENTS` em `app/helpers/odeio_front_end/component_register.rb` —
   o helper `meu(...)` passa a existir em todas as views automaticamente.
3. Escreva o spec antes (`spec/components/`).
