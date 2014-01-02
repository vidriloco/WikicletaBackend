if !Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['AWS_KEY'],       # required
      :aws_secret_access_key  => ENV['AWS_SECRET'],                        # required
      :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
      :endpoint               => 'http://s3-us-west-2.amazonaws.com' # optional, defaults to nil
    }
    config.fog_directory  = 'wikicleta'                     # required
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end