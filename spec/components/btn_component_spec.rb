require "rails_helper"

RSpec.describe OdeioFrontEnd::BtnComponent, type: :component do
  it "renderiza link com estilo padrão, menor" do
    render_inline(described_class.new("Salvar", "/salvar"))

    expect(page).to have_css("a.btn.btn-sm.btn-primary", text: "Salvar")
  end

  it "renderiza tamanho normal com size: :normal" do
    render_inline(described_class.new("Grande", "/grande", size: :normal))

    expect(page).to have_css("a.btn.btn-primary", text: "Grande")
    expect(page).to have_no_css("a.btn-sm")
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
