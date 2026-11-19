module OdeioFrontEnd
  class LinkEditComponent < BtnComponent
    def initialize(path, auth: true, html: {})
      super("Editar", path, style: :warning, auth: auth, html: html)
    end
  end
end
