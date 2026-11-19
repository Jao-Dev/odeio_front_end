module OdeioFrontEnd
  class LinkNewComponent < BtnComponent
    def initialize(path, auth: true, html: {})
      super("Novo", path, style: :primary, auth: auth, html: html)
    end
  end
end
