require 'uri'

module Phase5
  class Params
    def initialize(request, route_params = {})
      @params = Params.new(request: request, route_params: route_params)
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError
    end

    private
    def parse_www_encoded_form(www_encoded_form)
      key, value = URI::decode_www_form(www_encoded_form).first
      @params[key] = value
    end

    def parse_key(key)

    end
  end
end
