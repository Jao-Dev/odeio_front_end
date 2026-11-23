# Page-header (título/subtítulo/ações) + card de formulário com resumo de erros
# e footer Salvar/Cancelar. Envolva com form_with na view: = form_with model: @x do |f| = form_card 'Novo', f do ...
module OdeioFrontEnd
  class FormCardComponent < ApplicationComponent
    def initialize(title, form, subtitle: nil, actions: nil, cancel_path: nil,
                   submit_label: "Salvar", html: {})
      @title = title
      @form = form
      @subtitle = subtitle
      @actions = actions
      @cancel_path = cancel_path
      @submit_label = submit_label
      @html = html
    end

    private

    def actions_body
      @actions.is_a?(Array) ? safe_join(@actions, " ") : @actions
    end

    def render_actions?
      @actions.present?
    end

    def errors?
      @form.object.respond_to?(:errors) && @form.object.errors.any?
    end

    def errors_summary
      content_tag :div, class: "alert alert-danger", role: "alert" do
        content_tag(:h4, "Erros encontrados:", class: "alert-heading") +
          safe_join(@form.object.errors.full_messages.map { |m| content_tag(:p, m) })
      end
    end

    def cancel_path
      @cancel_path || :back
    end
  end
end
