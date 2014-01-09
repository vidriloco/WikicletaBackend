class Api::CyclePathsController < Api::BaseController
  
  protect_from_forgery :except => [:index]
  
  api :GET, '/cycle_paths', "Fetches the cycle paths within the provided viewport"
  param :cycle_paths, Hash do
    param :sw, String, 'Coordinate pair defining south-west screen point'
    param :ne, String, 'Coordinate pair defining north-east screen point'
  end
  description <<-EOS
    == About the response
    The response for this request is an array of objects with the form:
        {"success":true,"cycle_paths":[{"category":2,"content":"Estos son atajos ciclistas muy buenos","dislikes_count":0,"id":52,"likes_count":0,"str_created_at":"2013-11-02 09:11:42","str_updated_at":"2013-11-02 09:12:29","lat":24.83281,"lon":-107.387276,"owner":{"username":"Punksolid","id":14}}]}
    Some details on the response attributes:
    * *pic* An attribute on the user object of the response which contains a URL of the user picture (An optional attribute)
    * *category* A numeric attribute which can take one of the following values: 1 for _danger_, 2 for _alert_ or 3 for _sightseeing_ . This values should be localized on the applications
  EOS
  def index
    @cycle_paths = CyclePath.find_nearby(params[:viewport])
    render :json => {:success => true, :cycle_paths => @cycle_paths.as_json}, :status => :ok
  end

end