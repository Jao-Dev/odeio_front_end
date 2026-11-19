module OdeioFrontEnd
  class CardComponent < ApplicationComponent
    def initialize(title = nil, actions: nil, html: {})
      @title = title
      @actions = actions
      @html = html
    end

    def render_header?
      @title || @actions.present?
    end

    private

    def actions_body
      @actions.is_a?(Array) ? safe_join(@actions, " ") : @actions
    end
  end
end
