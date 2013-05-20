if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider           => 'Rackspace',
      :rackspace_username => 'vidriloco',
      :rackspace_api_key  => 'ecd0d0ca89092f8299f4d8178ab823bb'
    }
    config.fog_directory = 'wikicleta'
    config.fog_host = "http://7f81635322f22f9c8430-2c43e3cccc7a9a510413dd8cb2a62365.r57.cf1.rackcdn.com"
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end