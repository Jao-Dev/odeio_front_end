module OdeioFrontEnd
  class TableComponent < ApplicationComponent
    def initialize(headers: [], hover: false, striped: false, html: {})
      @headers = headers
      @hover = hover
      @striped = striped
      @html = html
    end

    private

    def table_classes
      [ "table", "table-vcenter", "card-table", ("table-hover" if @hover),
        ("table-striped" if @striped) ].compact
    end
  end
end
