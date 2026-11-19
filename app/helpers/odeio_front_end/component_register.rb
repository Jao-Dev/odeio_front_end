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
    ].freeze

    included do
      COMPONENTS.each do |component_name|
        component_class = "OdeioFrontEnd::#{component_name.to_s.camelize}Component".constantize

        define_method(component_name) do |*args, **kwargs, &block|
          component = component_class.new(*args, **kwargs)
          component = component.with_content(capture(&block)) if block
          render(component)
        end
      end
    end
  end
end
