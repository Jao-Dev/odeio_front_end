require "rails_helper"

RSpec.describe OdeioFrontEnd::BadgeComponent, type: :component do
  it "renderiza badge com estilo padrão" do
    render_inline(described_class.new("Pendente"))

    expect(page).to have_css("span.badge.bg-secondary-lt", text: "Pendente")
  end

  it "aceita estilo customizado" do
    render_inline(described_class.new("Ativa", style: :success))

    expect(page).to have_css("span.badge.bg-success-lt", text: "Ativa")
  end
end
