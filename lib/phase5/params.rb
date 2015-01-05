require 'uri'

module Phase5
  class Params
    def initialize(request, route_params = {})
      @params = {}
      @params.merge!(route_params)
      @params.merge!(parse_www_encoded_form(request.body)) if request.body
      if request.query_string
        @params.merge!(parse_www_encoded_form(request.query_string))
      end
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
      params = {}
      key_values = URI.decode_www_form(www_encoded_form)

      key_values.each do |full_key, value|
        scope = params
        key_seq = parse_key(full_key)

        key_seq.each_with_index do |key, index|
          if (index + 1) == key_seq.length
            scope[key] = value
          else
            scope[key] ||= {}
            scope = scope[key]
          end
        end
      end
      params
    end

    def parse_key(key)
      key.split(/\[|\]\[|\]/)
    end
  end
end
