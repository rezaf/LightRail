require 'webrick'
require_relative '../lib/phase6/controller_base'
require_relative '../lib/phase6/router'

$cats = [
  { id: 1, name: "Nickie" },
  { id: 2, name: "Marie" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Nickie loves string!" },
  { id: 2, cat_id: 2, text: "Marie is mighty!" },
  { id: 3, cat_id: 1, text: "Nickie is cool!" }
]

class StatusesController < Phase6::ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params[:cat_id])
    end
    render_content(statuses.to_s, "text/text")
  end
end

class Cats2Controller < Phase6::ControllerBase
  def index
    render_content($cats.to_s, "text/text")
  end
end

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/cats$"), Cats2Controller, :index
  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |request, response|
  route = router.run(request, response)
end
trap('INT') { server.shutdown }
server.start
