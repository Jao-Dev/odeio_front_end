module OdeioFrontEnd
  class LinkShowComponent < BtnComponent
    def initialize(path, auth: true, html: {})
      super("Ver", path, style: :info, auth: auth, html: html)
    end
  end
end
