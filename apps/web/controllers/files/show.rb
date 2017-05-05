require 'aws-sdk'
module Web::Controllers::Files
  class Show
    include Web::Action

    expose :files

    def call(params)
      file = db[:remote_files].where(file_id: params[:id]).first
      key = file[:key]
      bucket = file[:bucket]
      region = file[:region]
      filename = file[:name]


      s3 = Aws::S3::Resource.new(region: region)

      # Create the object to retrieve
      obj = s3.bucket(bucket).object(key)

      uri = ::File.join(Dir.pwd,"public", params[:id] ,filename)
      dirname = ::File.dirname(uri)

      unless ::File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      self.body = obj.get.body
    end

    def db
      @db ||= Sequel.postgres('read_model', host:'localhost', user: 'event_source')
    end
  end
end
