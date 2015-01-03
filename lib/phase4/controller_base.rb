require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super(url)
      session.store_session(response)
    end

    def render_content(body, content_type)
      super(body, content_type)
      session.store_session(response)
    end

    def session
      @session ||= Session.new(self.request)
    end
  end
end
