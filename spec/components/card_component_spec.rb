require "rails_helper"

RSpec.describe OdeioFrontEnd::CardComponent, type: :component do
  it "renderiza título no header e o conteúdo" do
    render_inline(described_class.new("Ficha")) { "<p>conteúdo</p>".html_safe }

    expect(page).to have_css("h1.card-title", text: "Ficha")
    expect(page).to have_css(".card", text: "conteúdo")
  end

  it "renderiza ações no header" do
    render_inline(described_class.new("Ficha", actions: "<a href='/e'>Editar</a>".html_safe))

    expect(page).to have_css(".card-header .ms-auto a", text: "Editar")
  end

  it "não renderiza header sem título nem ações" do
    render_inline(described_class.new) { "<p>sem header</p>".html_safe }

    expect(page).to have_no_css(".card-header")
    expect(page).to have_css(".card", text: "sem header")
  end
end
