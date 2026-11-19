require "rails_helper"

RSpec.describe "ComponentRegister", type: :request do
  it "expõe card e btn nas views do app host" do
    get "/teste/card"

    expect(response.body).to include("card-title")
    expect(response.body).to include("Ficha")
    expect(response.body).to include("conteúdo do card")
    expect(response.body).to include("Editar")
    expect(response.body).to include("card sem título")
  end

  it "expõe btn com method e confirm" do
    get "/teste/btn"

    expect(response.body).to include("Salvar")
    expect(response.body).to include("data-turbo-confirm=\"Confirma?\"")
    expect(response.body).not_to include("Oculto")
  end

  it "expõe links padronizados" do
    get "/teste/links"

    expect(response.body).to include("Ver")
    expect(response.body).to include("Editar")
    expect(response.body).to include("Novo")
    expect(response.body).to include("Excluir")
    expect(response.body).not_to include("/bloqueado")
  end
end
