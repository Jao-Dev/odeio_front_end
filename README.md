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

`btn` aceita `style:`, `size:`, `method:`, `confirm:` e `auth:`
(ao contrário do `ui_helper` antigo do ficha_rpg, o botão é pequeno (`btn-sm`)
por padrão — `size: :normal` para o tamanho grande).

## Formulários

O `form_with` fica na view (padrão Rails); a gem embrulha o resto:

```haml
= form_with model: @personagem do |f|
  = form_card 'Nova personagem', f, subtitle: 'Dados básicos',
    cancel_path: personagens_path, actions: [ btn('Voltar', personagens_path, style: :link) ] do
    = field f, :nome, label: 'Nome' do |html|
      = f.text_field :nome, html
    = money_field f, :preco, label: 'Preço'
    = select_field f, :classe, Classe.all, label: 'Classe', prompt: 'Selecione'
```

- `form_card` — page-header Tabler (título + subtítulo + `actions:` à direita),
  card com o corpo do formulário, resumo de erros do model (quando houver) e
  footer com `Salvar` (submit) e `Cancelar` (link para `cancel_path:`, padrão `:back`).
  Aceita também `submit_label:`.
- `field` — label + input + mensagem de erro + `hint:`. O bloco recebe o
  `html` pronto (com `form-control` e `is-invalid` quando o atributo tem erro):
  basta passar ao input do Rails.
- `select_field` — select estilizado (`form-select`); aceita pares
  `[['Texto', 'valor']]`, arrays de strings ou coleções de objetos
  (`value_method:`/`text_method:`, padrão `:id`/`:name`), além de `prompt:` e `include_blank:`.
- `money_field` — input numérico com prefixo de moeda (`R$`), `step: 0.01`, `min: 0`.

Todos aplicam `is-invalid` + mensagem de erro automaticamente a partir de
`f.object.errors`.

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
   (Se o bloco precisa receber argumentos, como no `field`, adicione também
   à lista `BLOCK_ARGS_COMPONENTS`.)
3. Escreva o spec antes (`spec/components/`).
