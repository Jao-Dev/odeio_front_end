module OdeioFrontEnd
  class LinkDestroyComponent < BtnComponent
    def initialize(path, auth: true, html: {})
      super("Excluir", path, style: :danger, method: :delete, confirm: "Deseja excluir?", auth: auth, html: html)
    end
  end
end
