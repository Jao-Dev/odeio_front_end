require "rails_helper"

RSpec.describe OdeioFrontEnd::FieldComponent, type: :component do
  let(:view) do
    ActionView::Base.empty.tap { |v| v.output_buffer = ActionView::OutputBuffer.new }
  end
  let(:personagem) { PersonagemFake.new }
  let(:form) { ActionView::Helpers::FormBuilder.new(:personagem, personagem, view, {}) }

  def select_component(**kwargs)
    OdeioFrontEnd::SelectFieldComponent.new(form, :classe, collection, **kwargs)
  end

  def money_component(**kwargs)
    OdeioFrontEnd::MoneyFieldComponent.new(form, :preco, **kwargs)
  end

  describe "field" do
    it "renderiza label e input com form-control" do
      component = described_class.new(form, :nome, label: "Nome") do |html|
        form.text_field :nome, html
      end
      render_inline(component)

      expect(page).to have_css(".mb-3 label.form-label", text: "Nome")
      expect(page).to have_css("input.form-control[name='personagem[nome]']")
      expect(page).to have_no_css(".is-invalid")
      expect(page).to have_no_css(".invalid-feedback")
    end

    it "repassa html extra ao bloco" do
      component = described_class.new(form, :nome, label: "Nome", html: { placeholder: "digite" }) do |html|
        form.text_field :nome, html
      end
      render_inline(component)

      expect(page).to have_css("input[placeholder='digite']")
    end

    context "com erro no atributo" do
      before { personagem.errors.add(:nome, "não pode ficar em branco") }

      it "marca o input como inválido e mostra a mensagem" do
        component = described_class.new(form, :nome, label: "Nome") do |html|
          form.text_field :nome, html
        end
        render_inline(component)

        expect(page).to have_css("input.form-control.is-invalid")
        expect(page).to have_css(".invalid-feedback", text: "não pode ficar em branco")
      end
    end

    it "renderiza hint" do
      component = described_class.new(form, :nome, label: "Nome", hint: "Sem abreviações") do |html|
        form.text_field :nome, html
      end
      render_inline(component)

      expect(page).to have_css(".form-hint", text: "Sem abreviações")
    end
  end

  describe "select_field" do
    subject(:renderizado) do
      render_inline(select_component(label: "Classe"))
      page
    end

    let(:collection) { [ %w[Guerreiro guerreiro], %w[Mago mago] ] }

    it { is_expected.to have_css("label.form-label", text: "Classe") }
    it { is_expected.to have_css("select.form-select[name='personagem[classe]']") }
    it { is_expected.to have_css("option[value='guerreiro']", text: "Guerreiro") }

    context "com objetos" do
      let(:collection) { [ Struct.new(:id, :nome).new(1, "Guerreiro") ] }
      subject(:renderizado) do
        render_inline(select_component(label: "Classe", text_method: :nome))
        page
      end

      it { is_expected.to have_css("option[value='1']", text: "Guerreiro") }
    end

    context "com prompt" do
      subject(:renderizado) do
        render_inline(select_component(label: "Classe", prompt: "Selecione"))
        page
      end

      it { is_expected.to have_css("option", text: "Selecione") }
    end

    context "com erro no atributo" do
      before { personagem.errors.add(:classe, "não pode ficar em branco") }

      it { is_expected.to have_css("select.form-select.is-invalid") }
      it { is_expected.to have_css(".invalid-feedback", text: "não pode ficar em branco") }
    end
  end

  describe "money_field" do
    subject(:renderizado) do
      render_inline(money_component(label: "Preço"))
      page
    end

    it { is_expected.to have_css("label.form-label", text: "Preço") }
    it { is_expected.to have_css(".input-group span.input-group-text", text: "R$") }
    it { is_expected.to have_css("input.form-control[type='number'][step='0.01'][min='0']") }

    context "com moeda customizada" do
      subject(:renderizado) do
        render_inline(money_component(label: "Preço", currency: "US$"))
        page
      end

      it { is_expected.to have_css(".input-group-text", text: "US$") }
    end

    context "com erro no atributo" do
      before { personagem.errors.add(:preco, "não é um número") }

      it { is_expected.to have_css("input.form-control.is-invalid") }
      it { is_expected.to have_css(".invalid-feedback", text: "não é um número") }
    end
  end
end
