require 'aws-sdk'
module Web::Controllers::Files
  class Show
    include Web::Action

    expose :files

    def call(params)
      file = db[:files].where(file_id: params[:id]).first
      key = file[:key]
      bucket = file[:bucket]
      region = file[:region]
      filename = file[:name]


      s3 = Aws::S3::Resource.new(region: region)

      # Create the object to retrieve
      obj = s3.bucket(bucket).object(key)

      uri = ::File.join(Dir.pwd,"tmp","download",Date.today.to_s, + "#{SecureRandom.hex}" ,filename)
      dirname = ::File.dirname(uri)

      unless ::File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      obj.get(response_target: uri)

      unsafe_send_file uri
    end

    def db
      @db ||= Sequel.postgres('file_transfer', host:'localhost', user: 'event_source')
    end
  end
end
