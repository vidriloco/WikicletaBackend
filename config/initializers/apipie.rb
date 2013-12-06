Apipie.configure do |config|
  config.app_name                = "Wikicleta"
  config.markup = Apipie::Markup::Markdown.new
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidoc"
  # were is your API defined?
  config.api_controllers_matcher = File.join(Rails.root, "app", "controllers", "**","*.rb")
  config.authenticate = Proc.new do
     authenticate_or_request_with_http_basic do |username, password|
       username == "bicito" && password == "apiel"
    end
  end
end
