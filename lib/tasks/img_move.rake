require 'open-uri'

namespace :move_images do
  desc "Move image files from CloudFiles to AS3"
  task :execute => :environment do
    Picture.all.each do |picture|
      if picture.imageable_type == "User" || picture.imageable_type == "CyclingGroup"
        begin
          open(picture.image.url, 'r') do |data|
            p "Processing: #{picture.image}"
            
            picture_type = picture.imageable_type.downcase
            picture_id = picture.imageable_id.to_s
            image_name = picture.image.url.split('/').last
            
            picture_new_name = "#{picture.id}_#{picture_type}_#{picture_id}_#{image_name}"
            
            file = File.new Rails.root.join("public", "backup", picture_new_name), "w"
            file.write open(data).read
            file.close
            
            picture.update_attribute(:image, picture_new_name)
          end
        rescue OpenURI::HTTPError => ex
          puts "Image not found for resource: #{picture.imageable_type} with id: #{picture.imageable_id}"
        rescue StandardError 
          puts "Picture not set on: #{picture.id}"
        end
      end
    end
  end
end
