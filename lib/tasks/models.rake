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
end
