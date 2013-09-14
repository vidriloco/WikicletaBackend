class Profiles::CyclingGroupsController < ProfilesController
  layout 'trips'
  
  before_filter :authenticate_user!
  before_filter :set_user
  
  def new
    @cycling_group = CyclingGroup.new
  end
  
  def create
    @cycling_group = CyclingGroup.new_with(params[:cycling_group], params[:coordinates])
    if @cycling_group.save
      @cycling_group.set_logo_and_user(params[:picture], @user)
      redirect_to trips_country_city_code_path('mx', @cycling_group.city.code), :notice => I18n.t("cycling_groups.views.created.success") 
    else
      render :action => :new
    end
  end
  
  private
  def set_user
    @user ||= current_user
  end
  
end
