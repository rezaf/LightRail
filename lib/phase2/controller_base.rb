module Phase2
  class ControllerBase
    attr_reader :request, :response

    def initialize(request, response)
      @request = request
      @response = response
      @already_built_response = false
    end

    def already_built_response?
      @already_built_response
    end

    def redirect_to(url)
      raise exception if already_built_response?
      @response.status = 302
      @response["Location"] = url
      @already_built_response = true
    end

    def render_content(body, content_type)
      raise exception if already_built_response?
      @response.body = body
      @response.content_type = content_type
      @already_built_response = true
    end
  end
end
