class Aggregator
  def self.all_activity_of(user)
    (Workshop.recent(user, :only_owned => true)+
      Parking.recent(user, :only_owned => true)+
      Incident.recent(user, :only_owned => true)+
      Bike.recent(user, :only_owned => true)+
      Tip.recent(user, :only_owned => true)).sort_by(&:updated_at).reverse!
  end
  
  def self.all_activity_on_wikicleta_as(user)
    #Refactor recent method to module of included models
     (Workshop.recent(user)+
      Parking.recent(user)+
      Incident.recent(user)+
      Bike.recent(user)+
      Tip.recent(user)).sort_by(&:updated_at).reverse!
  end
end