require 'active_support/core_ext'
require 'webrick'
require_relative '../lib/phase5/controller_base'

class Cat
  attr_reader :name, :owner

  def self.all
    @cat ||= []
  end

  def initialize(params = {})
    # params ||= {}
    @name = params["name"]
    @owner = params["owner"]
  end

  def save
    return false unless @name.present? && @owner.present?

    Cat.all << self
    true
  end

  def inspect
    { name: name, owner: owner }.inspect
  end
end

class CatsController < Phase5::ControllerBase
  def create
    @cat = Cat.new(params["cat"])
    if @cat.save
      redirect_to("/cats")
    else
      render :new
    end
  end

  def index
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |request, response|
  case [request.request_method, request.path]
  when ['GET', '/cats']
    CatsController.new(request, response, {}).index
  when ['POST', '/cats']
    CatsController.new(request, response, {}).create
  when ['GET', '/cats/new']
    CatsController.new(request, response, {}).new
  end
end
trap('INT') { server.shutdown }
server.start
