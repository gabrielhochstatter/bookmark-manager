require 'pg'
require 'uri'

class Bookmark
  attr_reader :url, :id, :title

  def initialize(id, url, title = 'untitled')
    @id = id
    @url = url
    @title = title
  end



  def self.all

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.add(url, title = 'untitled')
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING url, id, title;")
    Bookmark.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def self.is_valid_url?(url)
    url_regexp = /\A#{URI::regexp}\z/
    url =~ url_regexp ? true : false

  end

  def ==(other)
    @id == other.id
  end
end
