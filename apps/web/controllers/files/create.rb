require 'file_transfer/client'

module Web::Controllers::Files
  class Create
    include Web::Action

    def initate
      @initiate ||= FileTransfer::Client::Initiate.build
    end

    def call(params)
      filename = params[:file][:filename]
      #TODO Pre-generate Id and cache in ID folder
      uri = ::File.join(Dir.pwd,"tmp",Date.today.to_s, filename + "-#{SecureRandom.hex}")
      dirname = ::File.dirname(uri)
      
      unless ::File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      ::File.open(uri, 'w') { |file| file.write(params[:file][:tempfile].read) }

      FileTransfer::Client::Initiate.(filename, uri)

      redirect_to '/'
    end
  end
end
