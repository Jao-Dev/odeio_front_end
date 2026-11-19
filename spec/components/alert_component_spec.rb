require "rails_helper"

RSpec.describe OdeioFrontEnd::AlertComponent, type: :component do
  it "renderiza mensagem com a classe do tipo" do
    render_inline(described_class.new(:danger, "Erro ao salvar"))

    expect(page).to have_css(".alert.alert-danger[role=alert]", text: "Erro ao salvar")
  end

  it "renderiza conteúdo via bloco" do
    render_inline(described_class.new(:success)) { "Deu certo".html_safe }

    expect(page).to have_css(".alert.alert-success", text: "Deu certo")
  end
end
