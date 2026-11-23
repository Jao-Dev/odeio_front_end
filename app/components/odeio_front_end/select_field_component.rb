# Select estilizado (form-select) com label/erro/hint; aceita pares, strings ou objetos.
# Uso: = select_field f, :classe, Classe.all, label: 'Classe', prompt: 'Selecione'
module OdeioFrontEnd
  class SelectFieldComponent < FieldComponent
    def initialize(form, attr, collection, label: nil, value_method: :id, text_method: :name,
                   prompt: nil, include_blank: nil, hint: nil, html: {})
      super(form, attr, label: label, hint: hint, html: html)
      @collection = collection
      @value_method = value_method
      @text_method = text_method
      @prompt = prompt
      @include_blank = include_blank
    end

    private

    def input_body
      @form.select @attr, choices, { prompt: @prompt, include_blank: @include_blank }, input_html
    end

    def input_base_class
      "form-select"
    end

    def choices
      @collection.map do |item|
        next item if item.is_a?(Array)
        next [ item, item ] if item.is_a?(String)

        [ item.public_send(@text_method), item.public_send(@value_method) ]
      end
    end
  end
end
