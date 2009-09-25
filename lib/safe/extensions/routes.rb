if defined?(ActionController::Routing::RouteSet)
  class ActionController::Routing::RouteSet
    def load_routes_with_safe!
      lib_path = File.dirname(__FILE__)
      safe_routes = File.join(lib_path, *%w[.. .. .. config safe_routes.rb])
      unless configuration_files.include?(safe_routes)
        add_configuration_file(safe_routes)
      end
      load_routes_without_safe!
    end

    alias_method_chain :load_routes!, :safe
  end
end
