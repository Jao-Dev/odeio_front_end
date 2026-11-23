# Guia de componentes

Referência rápida da gem: uso por área de view + parâmetros de cada widget
(no estilo do README do UENF Layout). Uso detalhado e instalação no README.

## Uso por área de view

### View de listagem (index)

`card` com `actions:` no topo > `table` com as linhas; sem registros, `empty`.
Coluna de estado usa `badge`; ações por linha usam `link_show`/`link_edit`/`link_destroy`.

```haml
= card 'Agendamentos', actions: [ link_new(new_agendamento_path) ] do
  - if @agendamentos.any?
    = table headers: ['Cliente', 'Status'] do
      - @agendamentos.each do |a|
        %tr
          %td= a.cliente
          %td= badge(a.status, style: :info)
          %td
            = link_show agendamento_path(a)
            = link_edit edit_agendamento_path(a)
            = link_destroy agendamento_path(a)
  - else
    = empty 'Nenhum agendamento.'
```

### View de formulário (new/edit)

`form_with` fica na view; `form_card` embrulha header + card + erros + footer
Salvar/Cancelar; campos via `field`/`select_field`/`money_field`.

```haml
= form_with model: @agendamento do |f|
  = form_card 'Novo agendamento', f, cancel_path: agendamentos_path do
    = field f, :cliente, label: 'Cliente' do |html|
      = f.text_field :cliente, html
    = select_field f, :profissional_id, @profissionais, label: 'Profissional', prompt: 'Selecione'
    = money_field f, :preco, label: 'Preço'
```

### View de exibição (show)

`card` com o conteúdo; estados com `badge`. (Lacuna atual: não há widget para
pares rótulo/valor como o `show_item` do UENF Layout — candidata futura.)

### Mensagens / feedback

`alert` para flashes e avisos — típico no layout: `alert(:success, notice)`.

### Ações e navegação

`btn` para ação isolada na página (inclusive no `actions:` do card);
`link_show`/`link_edit`/`link_new`/`link_destroy` para CRUD padronizado.

## Widgets

### card

Container de conteúdo com header opcional (título + ações à direita).

Parâmetros:

- **title**, `string`, default: `nil`, Título no header (header some se título e actions vazios)
- **:actions**, `array|string`, default: `nil`, Botões/links à direita do header
- **:html**, `hash`, default: `{}`, Atributos HTML complementares do `.card`

O conteúdo vem do bloco.

```haml
= card 'Agendamentos', actions: [ btn('Novo', new_path) ] do
  ...
```

### table

Tabela responsiva dentro de `.card` (usar sempre dentro de um `card`).

Parâmetros:

- **:headers**, `array`, default: `[]`, Cabeçalhos das colunas
- **:hover**, `boolean`, default: `false`, Realce a linha sob o cursor
- **:striped**, `boolean`, default: `false`, Linhas alternadas coloridas
- **:html**, `hash`, default: `{}`, Atributos HTML complementares da `<table>`

O bloco fornece as linhas (`%tr`), que caem no `tbody`.

```haml
= table headers: ['Nome', 'Status'], hover: true do
  - registros.each do |r|
    %tr
      %td= r.nome
```

### empty

Mensagem de lista vazia (parágrafo discreto, `text-secondary`).

Parâmetros:

- **message**, `string`, `requerido`, Mensagem exibida

```haml
= empty 'Nenhuma personagem.'
```

### alert

Mensagem de feedback com cor por tipo (Bootstrap/Tabler).

Parâmetros:

- **kind**, `symbol`, `requerido`, `:success`, `:danger`, `:warning`, `:info`…
- **message**, `string`, default: `nil`, Texto; omitido, o bloco vira o conteúdo

```haml
= alert :success, 'Agendamento criado.'
```

### badge

Rótulo de estado, estilo Tabler (fundo translúcido).

Parâmetros:

- **text**, `string`, `requerido`, Texto do rótulo
- **:style**, `symbol`, default: `:secondary`, Cor (`:success`, `:danger`, `:info`, `:warning`…)

```haml
= badge confirmado, style: :success
```

### btn

Botão (link ou `button_to` quando `method:` informado).

Parâmetros:

- **label**, `string`, `requerido`, Texto do botão
- **path**, `string|helper`, `requerido`, Destino
- **:style**, `symbol`, default: `:primary`, Cor (`:secondary`, `:danger`, `:warning`, `:link`…)
- **:size**, `symbol`, default: `:small`, `:normal` para o tamanho grande
- **:method**, `symbol`, default: `nil`, `:post`, `:patch`, `:delete`… (via `button_to`)
- **:confirm**, `string`, default: `nil`, Confirmação (Turbo) — com `method:`
- **:auth**, `boolean`, default: `true`, `false` não renderiza nada (útil com Pundit)
- **:html**, `hash`, default: `{}`, Atributos HTML complementares

```haml
= btn 'Enviar email', envio_path, method: :post, confirm: 'Confirma?'
= btn 'Excluir', path, style: :danger, method: :delete, confirm: 'Confirma?'
```

### link_show / link_edit / link_new / link_destroy

CRUD padronizado — texto, cor e comportamento fixos (herdam de `btn`):

- **link_show** — `Ver`, `:info`
- **link_edit** — `Editar`, `:warning`
- **link_new** — `Novo`, `:primary`
- **link_destroy** — `Excluir`, `:danger`, DELETE com confirmação

Parâmetros (todos):

- **path**, `string|helper`, `requerido`, Destino
- **:auth**, `boolean`, default: `true`, `false` não renderiza
- **:html**, `hash`, default: `{}`, Atributos HTML complementares

```haml
= link_show agendamento_path(a), auth: policy(a).show?
```

### form_card

Página de formulário: page-header (título + subtítulo + ações) + card com o
corpo + resumo de erros do model + footer `Salvar`/`Cancelar`. O `form_with`
fica na view.

Parâmetros:

- **title**, `string`, `requerido`, Título do page-header
- **form**, `FormBuilder`, `requerido`, Builder do `form_with` da view
- **:subtitle**, `string`, default: `nil`, Texto sob o título
- **:actions**, `array|string`, default: `nil`, Botões/links à direita do header
- **:cancel_path**, `string|helper`, default: `:back`, Destino do Cancelar
- **:submit_label**, `string`, default: `"Salvar"`, Texto do botão de submit
- **:html**, `hash`, default: `{}`, Atributos HTML complementares da raiz

O bloco fornece os campos.

```haml
= form_with model: @agendamento do |f|
  = form_card 'Novo agendamento', f, subtitle: 'Dados básicos',
    cancel_path: agendamentos_path do
    ...
```

### field

Campo genérico: label + input (do bloco) + mensagem de erro + hint.

Parâmetros:

- **form**, `FormBuilder`, `requerido`, Builder do `form_with`
- **attr**, `symbol`, `requerido`, Atributo do model (lê erros dele)
- **:label**, `string`, default: `nil`, Texto do label (padrão: nome humanizado)
- **:hint**, `string`, default: `nil`, Texto de apoio sob o campo
- **:html**, `hash`, default: `{}`, Atributos extras somados ao input

O bloco recebe `html` já com `form-control` (e `is-invalid` com erro) — passe
direto ao input do Rails:

```haml
= field f, :inicio, label: 'Início' do |html|
  = f.datetime_local_field :inicio, html
```

### select_field

Select estilizado (`form-select`) com label/erro/hint; deriva de `field`.

Parâmetros:

- **form**, `FormBuilder`, `requerido`
- **attr**, `symbol`, `requerido`
- **collection**, `array|ActiveRecord`, `requerido`, Pares `[['Texto', 'valor']]`,
  strings ou objetos (`value_method:`/`text_method:`)
- **:label**, `string`, default: `nil`
- **:value_method**, `symbol`, default: `:id`, Método do valor (coleção de objetos)
- **:text_method**, `symbol`, default: `:name`, Método do texto (coleção de objetos)
- **:prompt**, `string|boolean`, default: `nil`, Opção "selecione"
- **:include_blank**, `string|boolean`, default: `nil`, Opção em branco
- **:hint**, `string`, default: `nil`
- **:html**, `hash`, default: `{}`

```haml
= select_field f, :profissional_id, @profissionais, label: 'Profissional', prompt: 'Selecione'
```

### money_field

Input monetário: prefixo de moeda + `number_field` (`step: 0.01`, `min: 0`);
deriva de `field`.

Parâmetros:

- **form**, `FormBuilder`, `requerido`
- **attr**, `symbol`, `requerido`
- **:label**, `string`, default: `nil`
- **:currency**, `string`, default: `"R$"`, Prefixo exibido à esquerda
- **:hint**, `string`, default: `nil`
- **:html**, `hash`, default: `{}`

```haml
= money_field f, :preco, label: 'Preço', currency: 'US$'
```
