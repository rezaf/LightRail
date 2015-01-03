require 'webrick'
require_relative '../lib/phase4/controller_base'

class MyController < Phase4::ControllerBase
  def go
    session["count"] ||= 0
    session["count"] += 1
    render :counting_show
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |request, response|
  MyController.new(request, response).go
end
trap('INT') { server.shutdown }
server.start
