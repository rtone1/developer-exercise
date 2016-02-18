require 'bundler'
Bundler.require()

require './youtubeModel.rb'

#routes
get '/' do #ROOT ROUTE
  erb :index
end

get "/youtube/search?" do      #API TO SEARCH YOUTUBE CLIENT
    result = YouTube.new.main(params[:q])
    result.to_json
end
