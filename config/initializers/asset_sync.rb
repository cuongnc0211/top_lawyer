AssetSync.configure do |config|
   config.fog_provider = 'AWS'
   config.aws_access_key_id = ENV["AWS_ACCESS_KEY_ID"]
   config.aws_secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
   # To use AWS reduced redundancy storage.
   # config.aws_reduced_redundancy = true
   config.fog_directory = ENV["S3_BUCKET_NAME"]

   # Invalidate a file on a cdn after uploading files
   # config.cdn_distribution_id = "12345"
   # config.invalidate = ['file1.js']

   # Increase upload performance by configuring your region
   config.fog_region = ENV["AWS_REGION"]
   #
   # Don't delete files from the store
   # config.existing_remote_files = "keep"

   # Auto sync after precompile
   config.run_on_precompile = false
   #
   # Automatically replace files with their equivalent gzip compressed version
   config.gzip_compression = true
   #
   # Use the Rails generated 'manifest.yml' file to produce the list of files to
   # upload instead of searching the assets directory.
   # config.manifest = true
   #
   # Fail silently.  Useful for environments such as Heroku
   # config.fail_silently = true
   #
   # Log silently. Default is `true`. But you can set it to false if more logging message are preferred.
   # Logging messages are sent to `STDOUT` when `log_silently` is falsy
   # config.log_silently = true
   #
   # Allow custom assets to be cacheable. Note: The base filename will be matched
   # If you have an asset with name `app.0ba4d3.js`, only `app.0ba4d3` will need to be matched
   # config.cache_asset_regexps = [ /\.[a-f0-9]{8}$/i, /\.[a-f0-9]{20}$/i ]
   # config.cache_asset_regexp = /\.[a-f0-9]{8}$/i
 end
