module FrenchToast
  class PayloadProcessor
    def initialize(partial_name:, locals: {})
      @partial_name = partial_name
      @locals = locals
    end

    def process
      ApplicationController.render(
        partial: "french_toast/#{partial_name}",
        locals: locals,
      )
    end

    private

    attr_reader :partial_name, :locals
  end
end
