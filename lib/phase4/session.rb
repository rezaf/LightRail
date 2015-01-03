require 'json'
require 'webrick'

module Phase4
  class Session
    def initialize(request)
      @session = {}
      request.cookies.each do |cookie|
        if cookie.name.to_s == "LightRail"
          @session = JSON.parse(cookie.value)
        end
      end
    end

    def [](key)
      @session[key]
    end

    def []=(key, value)
      @session[key] = value
    end

    def store_session(response)
      new_cookie = WEBrick::Cookie.new('LightRail', @session.to_json)
      response.cookies << new_cookie
    end
  end
end
