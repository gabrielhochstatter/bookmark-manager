require 'sinatra/base'
require 'sinatra/flash'
require_relative 'lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

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

    Bookmark.add(params[:url], params[:title])
    redirect to('/')
  end

  post '/delete' do
    Bookmark.delete(params[:id])
    redirect to('/')
  end

  get '/update' do
    @id = params[:id]
    @old_title = params[:old_title]
    @old_url = params[:old_url]
    erb(:update)
  end

  post '/updating' do
    Bookmark.update(params[:id], params[:new_url], params[:new_title])
    redirect to('/')
  end




  run! if app_file == $0

end
