require 'uri'

module Phase5
  class Params
    def initialize(req, route_params = {})
    end

    def [](key)
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError
    end

    private
    def parse_www_encoded_form(www_encoded_form)
    end

    def parse_key(key)
    end
  end
end
