require "carrierwave/orm/activerecord"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if ENV["CDN_UPLOADER"] == "true"
    config.fog_credentials = {
      provider:                "AWS",
      aws_access_key_id:       ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key:   ENV["AWS_SECRET_ACCESS_KEY"],
      region:                  ENV["AWS_REGION"],
      path_style:              true
    }
    config.storage :fog
    config.fog_directory  = ENV['S3_BUCKET_NAME']
    config.fog_public = Settings.carrierwave.fog_public
    config.fog_authenticated_url_expiration = eval(Settings.carrierwave.fog_expiration)
    config.fog_attributes = {
      "Cache-Control" => "max-age=#{eval(Settings.carrierwave.fog_cache_control).to_i}"
    }
    config.asset_host = ENV["CDN_ASSET_HOST"]
  else
    config.storage :file
    config.root = "#{Rails.root}/tmp"
    config.cache_dir = "#{Rails.root}/tmp/images"
    config.asset_host = ENV["LOCAL_ASSET_HOST"]
  end
end
