require "rails_helper"

RSpec.describe "Links padronizados", type: :component do
  it "link_show mostra Ver em estilo info" do
    render_inline(OdeioFrontEnd::LinkShowComponent.new("/teste/1"))

    expect(page).to have_css("a.btn.btn-info", text: "Ver")
  end

  it "link_edit mostra Editar em estilo warning" do
    render_inline(OdeioFrontEnd::LinkEditComponent.new("/teste/1/edit"))

    expect(page).to have_css("a.btn.btn-warning", text: "Editar")
  end

  it "link_new mostra Novo em estilo primary" do
    render_inline(OdeioFrontEnd::LinkNewComponent.new("/teste/novo"))

    expect(page).to have_css("a.btn.btn-primary", text: "Novo")
  end

  it "link_destroy mostra Excluir em estilo danger com DELETE e confirmação" do
    render_inline(OdeioFrontEnd::LinkDestroyComponent.new("/teste/1"))

    expect(page).to have_css("form.button_to[action='/teste/1']")
    expect(page).to have_css("button.btn.btn-danger", text: "Excluir")
    expect(page).to have_css("button[data-turbo-confirm='Deseja excluir?']")
  end

  it "não renderiza quando auth: false" do
    render_inline(OdeioFrontEnd::LinkShowComponent.new("/teste/1", auth: false))

    expect(page).to have_no_css("a.btn")
  end
end
