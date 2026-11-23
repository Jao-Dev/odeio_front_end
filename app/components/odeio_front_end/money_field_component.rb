# Input monetário: prefixo da moeda + number_field (step 0.01, min 0).
# Uso: = money_field f, :preco, label: 'Preço' (currency: 'R$' é o padrão)
module OdeioFrontEnd
  class MoneyFieldComponent < FieldComponent
    def initialize(form, attr, label: nil, currency: "R$", hint: nil, html: {})
      super(form, attr, label: label, hint: hint, html: html)
      @currency = currency
    end

    private

    def input_body
      content_tag :div, class: "input-group" do
        safe_join [ currency_tag, number_field_tag ]
      end
    end

    def currency_tag
      content_tag :span, @currency, class: "input-group-text"
    end

    def number_field_tag
      @form.number_field @attr, **input_html, min: 0, step: "0.01"
    end
  end
end
