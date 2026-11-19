module OdeioFrontEnd
  class BtnComponent < ApplicationComponent
    def initialize(label, path, style: :primary, size: nil, method: nil, confirm: nil, auth: true, html: {})
      @label = label
      @path = path
      @style = style
      @size = size
      @method = method
      @confirm = confirm
      @auth = auth
      @html = html
    end

    def render? = @auth

    def call
      classes = [ "btn", "btn-#{@style}", ("btn-sm" if @size == :small) ].compact.join(" ")

      if @method
        button_to @label, @path, method: @method, class: classes,
          form: { class: "button_to d-inline" },
          data: { turbo_confirm: @confirm }.compact_blank, **@html
      else
        link_to @label, @path, class: classes, **@html
      end
    end
  end
end
