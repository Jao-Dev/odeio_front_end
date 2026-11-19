module OdeioFrontEnd
  class AlertComponent < ApplicationComponent
    def initialize(kind, message = nil)
      @kind = kind
      @message = message
    end

    def call
      content_tag :div, @message || content, class: "alert alert-#{@kind}", role: "alert"
    end
  end
end
