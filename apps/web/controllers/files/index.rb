module Web::Controllers::Files
  class Index
    include Web::Action

    expose :files

    def call(params)
      @files = db[:files].to_a
    end

    def db
      @db ||= Sequel.postgres('file_transfer', host:'localhost', user: 'event_source')
    end
  end
end
