require 'sinatra/base'
require_relative 'lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    @bookmarks = Bookmark.all
    erb(:index)
  end

  get '/add' do
    erb(:add)
  end

  post '/adding' do
    Bookmark.add(params[:url])
    redirect to('/')
  end




  run! if app_file == $0

end
