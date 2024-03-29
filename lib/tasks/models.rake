namespace :models do
  desc "Updates the digested route path field"
  task :routes_update => :environment do
    ActiveRecord::Base.record_timestamps = false
    p "Deactivating AR record timestamps"
    Route.all.each do |route|
      p "Updating route with ID: #{route.id}"
      route.update_digested_path
      route.save
    end
    ActiveRecord::Base.record_timestamps = true
    p "Activating AR record timestamps"
    p "DONE!"
  end
  
  desc "Adds uniqueness username case insensitive migration until usernames are unique on database"
  task :users_migration_update => :environment do
    def retry_
      p "Retrying"
      Rake::Task["db:migrate"].execute
    end
    
    def fix(ex)
      username = ex.message.scan(/=\(([\w.]*)\)/).first.first
      p "Will update #{username} to #{username.downcase}_"
      User.where(:username => username).first.update_attribute(:username, "#{username.downcase}_")
    end
    
    begin 
      retry_
    rescue StandardError => ex
      fix(ex) 
      Rake::Task["models:users_migration_update"].execute
    end
  end
  
  task :users_username_downcase => :environment do
    User.all.each do |user|
      p "Downcasing #{user.username}"
      user.update_attribute(:username, user.username.downcase)
    end
  end
  
  #namespace :instants do
  #  task :assign_performant_users => :environment do
  #    ActiveRecord::Base.record_timestamps = false
  #    Instant.where(:user_id => nil).includes(:route_performance).each do |instant|
  #      instant.update_attribute(:user_id, instant.route_performance.user_id) unless instant.route_performance.nil?
  #      p "Updated instant #{instant.id} for UID: #{instant.user_id}"
  #    end
  #    ActiveRecord::Base.record_timestamps = true
  #  end
  #end

end
