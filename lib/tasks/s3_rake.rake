namespace :s3_rake do
   desc "Put uploader data"
   task :put do
     ARGV[1] ||= "public/uploads"
     ARGV.each {|a| task a.to_sym do ; end}
     if ARGV[1].start_with?("public/")
       Dir.glob("#{ARGV[1]}/**/*").each do |file|
         next if File.directory?(file) || file.include?("/tmp/")
         puts "Put file: #{file}"
         upload_file file
       end
     end
   end
 end

 def upload_file file
   file_name = file.gsub "public/", ""
   s3 = Aws::S3::Resource.new region: ENV["AWS_REGION"]
   obj = s3.bucket(ENV["S3_BUCKET_NAME"]).object(file_name)
   obj.upload_file file
 end
