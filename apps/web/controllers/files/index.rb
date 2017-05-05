module Web::Controllers::Files
  class Index
    include Web::Action

    expose :files

    def call(params)
      @files = db[:remote_files].to_a
    end

    def db
      @db ||= Sequel.postgres('read_model', host:'localhost', user: 'event_source')
    end
  end
end
