require 'webrick'
require_relative '../lib/phase2/controller_base'

class MyController < Phase2::ControllerBase
  def go
    if @request.path == "/test_location"
      render_content("We are in test location.", "text/html")
    else
      redirect_to("/test_location")
    end
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)

server.mount_proc('/') do |request, response|
  MyController.new(request, response).go
end

trap('INT') { server.shutdown }

server.start
