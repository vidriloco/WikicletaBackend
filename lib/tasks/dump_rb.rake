namespace :dump_rb do
  desc "Dump models data to .rb seed file"
  task :execute => :environment do
    output=String.new
    [AdminUser, City, User, CyclingGroup, CyclingGroupAdmin, Picture, Tip, Workshop, Parking].each do |klass|
      output << klass.model_dump
    end
    output << Ownership.populate_non_existent
    File.open(Rails.root.join('dump_seed.rb'), 'w') do |f|
      f.write output
    end
  end
end
