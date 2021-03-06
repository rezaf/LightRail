require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params

    def initialize(request, response, route_params = {})
      super(request, response)
      @params = Params.new(request, route_params)
    end
  end
end
