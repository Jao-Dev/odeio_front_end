module OdeioFrontEnd
  class EmptyComponent < ApplicationComponent
    def initialize(message)
      @message = message
    end

    def call
      content_tag :p, @message, class: "text-secondary"
    end
  end
end
