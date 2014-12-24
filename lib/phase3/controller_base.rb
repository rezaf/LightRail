require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      contents = File.read(
        "views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
      )
      tbind = ERB.new(contents).result(binding)
      render_content(tbind, "text/html")
    end
  end
end
