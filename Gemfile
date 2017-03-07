source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '1.0.0.beta2'

gem 'pg'
gem 'sequel'
gem 'aws-sdk'
gem 'file_transfer-client', github: "aarondufall/file-transfer-component"

group :development do
  gem 'byebug'
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
