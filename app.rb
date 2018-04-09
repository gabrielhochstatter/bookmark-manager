require 'sinatra/base'

class BookmarkManager < Sinatra::Base

  get '/' do
    "testing 123"
  end




  run! if app_file == $0

end
