require "rails_helper"

RSpec.describe OdeioFrontEnd::EmptyComponent, type: :component do
  it "renderiza mensagem de estado vazio" do
    render_inline(described_class.new("Nenhum personagem nesta campanha."))

    expect(page).to have_css("p.text-secondary", text: "Nenhum personagem nesta campanha.")
  end
end
