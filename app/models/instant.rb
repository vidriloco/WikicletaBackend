class Instant < ActiveRecord::Base
  include Api
  include Geography
  
  belongs_to :route_performance
  belongs_to :user
  
  def self.bulk_create(params, user)
    instants = []
    params.each do |instant_params|
      lon = instant_params.delete(:longitude)
      lat = instant_params.delete(:latitude)
      instant = Instant.new_with(instant_params, {"lon" => lon, "lat" => lat}, user)
      instants << instant if instant.save
    end
    user.update_rankeables
    instants
  end
  
  def self.new_with(params, coords, user)
    instant=Instant.new(params.merge(:user => user))
    instant.apply_geo(coords)
    instant
  end
  
  def self.collection_as_json(collection)
    return collection if collection[:instants].blank?
    dict_array = []
    collection[:instants].each do |instant|
      dict_array << instant.dictionary_to_json
    end
    collection[:instants] = dict_array
    collection
  end
  
  def dictionary_to_json
    {:id => id, :elapsed_time => elapsed_time, :str_created_at => str_created_at, :speed_at => speed_at, :lat => lat, :lon => lon, :distance_at => distance_at}
  end
  
  def as_json
    super({
      :only => [:id, :elapsed_time],
      :methods => [:str_created_at, :speed_at, :lat, :lon, :distance_at]
    })
  end
  
  def self.stats(user_id, start_date, end_date)
    {:speed => Instant.instants_with(user_id, {:start_date => start_date, :end_date => end_date, :speed => 35, :timing => 1000}).average('speed') || "0.0", 
        :distance => Instant.instants_with(user_id, {:start_date => start_date, :end_date => end_date, :speed => 35, :timing => 1000}).sum('distance')}
  end
  
  def self.all_within_range(user_id, start_date, end_date)
    instants = Instant.instants_with(user_id, {:start_date => start_date, :end_date => end_date, :speed => 35, :timing => 1000})
    {:instants => instants, :stats => Instant.stats(user_id, start_date, end_date) }
  end
  
  def self.instants_with(user_id, params)
    query="user_id = :user_id AND speed < :speed AND elapsed_time < :timing"
    hash= {:user_id => user_id, :speed => params[:speed], :timing => params[:timing]}
    
    unless params[:start_date].blank? && params[:end_date].blank?
      query += " AND created_at > :start_date AND created_at < :end_date"
      hash.merge!({:start_date => DateTime.parse(params[:start_date]), :end_date => DateTime.parse(params[:end_date])})
    end
    
    Instant.where(query, hash)
  end
  
  def speed_at
    speed.to_s
  end
  
  def distance_at
    distance.to_s
  end
end
