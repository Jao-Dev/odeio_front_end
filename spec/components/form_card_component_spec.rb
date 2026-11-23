require "rails_helper"

RSpec.describe OdeioFrontEnd::FormCardComponent, type: :component do
  let(:view) do
    ActionView::Base.empty.tap { |v| v.output_buffer = ActionView::OutputBuffer.new }
  end
  let(:personagem) { PersonagemFake.new }
  let(:form) { ActionView::Helpers::FormBuilder.new(:personagem, personagem, view, {}) }

  it "renderiza header com título, subtítulo e ações" do
    render_inline(described_class.new("Nova personagem", form,
      subtitle: "Dados básicos", actions: "<a href='/teste'>Voltar</a>".html_safe,
      cancel_path: "/teste/card")) { "conteúdo".html_safe }

    expect(page).to have_css(".page-header h2.page-title", text: "Nova personagem")
    expect(page).to have_css(".page-subtitle", text: "Dados básicos")
    expect(page).to have_css(".page-header .col-auto a", text: "Voltar")
  end

  it "renderiza o conteúdo no corpo do card" do
    render_inline(described_class.new("Nova personagem", form, cancel_path: "/teste/card")) do
      "<p>conteúdo</p>".html_safe
    end

    expect(page).to have_css(".card .card-body", text: "conteúdo")
  end

  it "renderiza footer com Salvar e Cancelar" do
    render_inline(described_class.new("Nova personagem", form, cancel_path: "/teste/card")) do
      "conteúdo".html_safe
    end

    expect(page).to have_css(".card-footer button[type='submit'].btn-primary", text: "Salvar")
    expect(page).to have_css(".card-footer a.btn-link[href='/teste/card']", text: "Cancelar")
  end

  it "permite customizar o texto do botão de salvar" do
    render_inline(described_class.new("Nova personagem", form, submit_label: "Agendar",
      cancel_path: "/teste/card")) { "conteúdo".html_safe }

    expect(page).to have_css(".card-footer button[type='submit']", text: "Agendar")
  end

  it "aplica html extra na raiz" do
    render_inline(described_class.new("Nova personagem", form, html: { id: "form-personagem" },
      cancel_path: "/teste/card")) { "conteúdo".html_safe }

    expect(page).to have_css("div#form-personagem .card")
  end

  context "quando o objeto tem erros" do
    before do
      personagem.errors.add(:nome, "não pode ficar em branco")
      personagem.errors.add(:preco, "não é um número")
    end

    it "mostra o resumo de erros no corpo" do
      render_inline(described_class.new("Nova personagem", form, cancel_path: "/teste/card")) do
        "conteúdo".html_safe
      end

      expect(page).to have_css(".card-body .alert.alert-danger", text: "não pode ficar em branco")
      expect(page).to have_css(".alert.alert-danger", text: "não é um número")
    end
  end

  context "quando o objeto não tem erros" do
    it "não mostra resumo de erros" do
      render_inline(described_class.new("Nova personagem", form, cancel_path: "/teste/card")) do
        "conteúdo".html_safe
      end

      expect(page).to have_no_css(".alert-danger")
    end
  end
end
