require 'webrick'
require_relative '../lib/phase3/controller_base'

class MyController < Phase3::ControllerBase
  def go
    render :show
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |request, response|
  MyController.new(request, response).go
end
trap('INT') { server.shutdown }
server.start
