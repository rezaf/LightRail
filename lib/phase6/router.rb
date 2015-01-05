module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern, @http_method = pattern, http_method
      @controller_class, @action_name = controller_class, action_name
    end

    def matches?(request)
      (http_method == request.request_method.downcase.to_sym) &&
                        !!(pattern =~ request.path)
    end

    def run(request, response)
      match_data = @pattern.match(request.path)

      route_params = {}
      match_data.names.each do |name|
        route_params[name] = match_data[name]
      end

      @controller_class
          .new(request, response, route_params)
          .invoke_action(action_name)
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    def add_route(pattern, method, controller_class, action_name)
      @routes << Route.new(pattern, method, controller_class, action_name)
    end

    def draw(&proc)
      instance_eval(&proc)
    end

    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |pattern, controller_class, action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
    end

    def match(request)
      routes.find { |route| route.matches?(request) }
    end

    def run(request, response)
      matching_route = match(request)
      if matching_route.nil?
        response.status = 404
      else
        matching_route.run(request, response)
      end
    end
  end
end
