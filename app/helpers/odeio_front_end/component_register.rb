module OdeioFrontEnd
  module ComponentRegister
    extend ActiveSupport::Concern

    COMPONENTS = %i[
      alert
      badge
      btn
      card
      empty
      table
      link_show
      link_edit
      link_new
      link_destroy
      form_card
      field
      select_field
      money_field
    ].freeze

    # Componentes cujo bloco recebe argumentos (ex.: hash de html do input).
    # O bloco NÃO é capturado como conteúdo: vai direto ao construtor.
    BLOCK_ARGS_COMPONENTS = %i[
      field
      select_field
      money_field
    ].freeze

    included do
      (COMPONENTS - BLOCK_ARGS_COMPONENTS).each do |component_name|
        component_class = "OdeioFrontEnd::#{component_name.to_s.camelize}Component".constantize

        define_method(component_name) do |*args, **kwargs, &block|
          component = component_class.new(*args, **kwargs)
          component = component.with_content(capture(&block)) if block
          render(component)
        end
      end

      BLOCK_ARGS_COMPONENTS.each do |component_name|
        component_class = "OdeioFrontEnd::#{component_name.to_s.camelize}Component".constantize

        define_method(component_name) do |*args, **kwargs, &block|
          render(component_class.new(*args, **kwargs, &block))
        end
      end
    end
  end
end
