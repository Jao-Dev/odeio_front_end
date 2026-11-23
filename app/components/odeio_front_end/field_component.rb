# Campo de formulário: label + bloco de input + mensagem de erro + hint.
# O bloco recebe o html pronto (form-control/is-invalid): = field f, :nome do |html| ...
module OdeioFrontEnd
  class FieldComponent < ApplicationComponent
    def initialize(form, attr, label: nil, hint: nil, html: {}, &block)
      @form = form
      @attr = attr
      @label = label
      @hint = hint
      @html = html
      @block = block
    end

    def call
      content_tag :div, safe_join(field_tags), class: "mb-3"
    end

    private

    def field_tags
      [ label_tag, input_body, feedback_tag, hint_tag ].compact
    end

    def label_tag
      @form.label @attr, @label, class: "form-label"
    end

    def input_body
      capture(input_html, &@block) if @block
    end

    def input_html
      classes = [ @html[:class], input_base_class, ("is-invalid" if invalid?) ].compact
      @html.merge(class: classes.join(" "))
    end

    def input_base_class
      "form-control"
    end

    def invalid?
      @form.object.respond_to?(:errors) && @form.object.errors[@attr].present?
    end

    def feedback_tag
      content_tag :div, @form.object.errors[@attr].first, class: "invalid-feedback d-block" if invalid?
    end

    def hint_tag
      content_tag :div, @hint, class: "form-hint" if @hint
    end
  end
end
