require "rails_helper"

RSpec.describe OdeioFrontEnd::TableComponent, type: :component do
  it "renderiza tabela com cabeçalhos e conteúdo" do
    render_inline(described_class.new(headers: %w[Nome Ações])) do
      "<tr><td>Aragorn</td><td></td></tr>".html_safe
    end

    expect(page).to have_css(".card .table-responsive table.table.card-table")
    expect(page).to have_css("thead th", text: "Nome")
    expect(page).to have_css("tbody td", text: "Aragorn")
  end

  it "aceita hover" do
    render_inline(described_class.new(headers: [ "Nome" ], hover: true))

    expect(page).to have_css("table.table-hover")
  end

  it "renderiza sem thead sem cabeçalhos" do
    render_inline(described_class.new) { "<tr><td>linha</td></tr>".html_safe }

    expect(page).to have_no_css("thead")
  end
end
