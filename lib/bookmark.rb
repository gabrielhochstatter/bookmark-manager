require 'pg'
require 'uri'

class Bookmark



  def self.all

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| bookmark['url'] }
  end

  def self.add(url)
    # raise "not a url" unless Bookmark.is_valid_url?(url)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}');")

  end

  def self.is_valid_url?(url)
    url_regexp = /\A#{URI::regexp}\z/
    url =~ url_regexp ? true : false

  end


end
