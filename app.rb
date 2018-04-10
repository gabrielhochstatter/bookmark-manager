require 'sinatra/base'
require_relative 'lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    @bookmarks = Bookmark.all
    erb(:index)
  end

  get '/add' do
    @invalid = params[:invalid]
    erb(:add)
  end

  post '/adding' do
    unless Bookmark.is_valid_url?(params[:url])
      redirect to('/add?invalid=1')
    end
    Bookmark.add(params[:url])
    redirect to('/')
  end




  run! if app_file == $0

end
