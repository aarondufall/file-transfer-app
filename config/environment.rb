require 'bundler/setup'
require 'hanami/setup'

require_relative '../apps/web/application'

require 'fileutils'

Hanami.configure do
  mount Web::Application, at: '/'

  mailer do
    # root 'lib/file_transfer_app/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
