# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'home#index'

post '/files', to: 'files#create'
get '/files', to: 'files#index'
get '/files/:id', to: 'files#show'
