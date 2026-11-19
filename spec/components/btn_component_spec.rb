require "rails_helper"

RSpec.describe OdeioFrontEnd::BtnComponent, type: :component do
  it "renderiza link com estilo padrão" do
    render_inline(described_class.new("Salvar", "/salvar"))

    expect(page).to have_css("a.btn.btn-primary", text: "Salvar")
    expect(page).to have_no_css("a.btn-sm")
  end

  it "renderiza menor com size: :small" do
    render_inline(described_class.new("Pequeno", "/pequeno", size: :small))

    expect(page).to have_css("a.btn.btn-sm", text: "Pequeno")
  end

  it "renderiza botão de form com method" do
    render_inline(described_class.new("Criar", "/criar", method: :post, confirm: "Confirma?"))

    expect(page).to have_css("form.button_to[action='/criar'][method=post]")
    expect(page).to have_css("button.btn", text: "Criar")
    expect(page).to have_css("button[data-turbo-confirm='Confirma?']")
  end

  it "não renderiza nada quando auth: false" do
    render_inline(described_class.new("Oculto", "/oculto", auth: false))

    expect(page).to have_no_css("a.btn")
  end

  it "aceita estilo customizado" do
    render_inline(described_class.new("Excluir", "/x", style: :danger, method: :delete))

    expect(page).to have_css("button.btn.btn-danger", text: "Excluir")
  end
end
