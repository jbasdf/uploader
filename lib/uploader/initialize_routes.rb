class ActionController::Routing::RouteSet
  def load_routes_with_uploader!
    uploader_routes = File.join(File.dirname(__FILE__), *%w[.. .. config uploader_routes.rb])
    add_configuration_file(uploader_routes) unless configuration_files.include? uploader_routes
    load_routes_without_uploader!
  end
  alias_method_chain :load_routes!, :uploader
end