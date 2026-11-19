module OdeioFrontEnd
  class BadgeComponent < ApplicationComponent
    def initialize(text, style: :secondary)
      @text = text
      @style = style
    end

    def call
      content_tag :span, @text, class: "badge bg-#{@style}"
    end
  end
end
