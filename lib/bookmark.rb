require 'pg'
require 'uri'
require_relative 'comment'
# require 'modules'

class Bookmark
  attr_reader :url, :id, :title

  def initialize(id, url, title = 'untitled')
    @id = id
    @url = url
    @title = title
  end

  def self.connection
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

  def self.all
    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.add(url, title = 'untitled')
    sql = "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING url, id, title;"
    result = connection.exec(sql, ["#{url}", "#{title}"])
    Bookmark.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def self.delete(id)
    sql = "DELETE FROM bookmarks WHERE id = $1;"
    connection.exec(sql, [id])
  end

  def self.find(id)
    Bookmark.all.select { |bookmark| bookmark.id == id }[0]
  end

  def self.update(id, new_url, new_title)
    sql = "UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3;"
    connection.exec(sql, ["#{new_url}", "#{new_title}", "#{id}"])
  end

  def self.is_valid_url?(url)
    url_regexp = /\A#{URI::regexp}\z/
    url =~ url_regexp ? true : false
  end

  def ==(other)
    @id == other.id
  end

  def comments
    Comment.all.select { |comment| comment.bookmark_id == @id }
  end

end
