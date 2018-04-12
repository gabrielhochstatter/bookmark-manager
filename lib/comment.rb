require 'pg'

class Comment
  
  attr_reader :id, :text, :bookmark_id

  def initialize(id, text, bookmark_id)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM comments")
    result.map { |comment| Comment.new(comment['id'], comment['text'], comment['bookmark_id'])  }
  end

  def self.add(text = 'default comment', bookmark_id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    sql = "INSERT INTO comments (text, bookmark_id) VALUES($1, $2) RETURNING text, id, bookmark_id;"
    result = connection.exec(sql, [text, bookmark_id])
    Comment.new(result.first['id'], result.first['text'], result.first['bookmark_id'])
  end

  def ==(other)
    @id == other.id
  end

  ### FOR TESTING ONLY IGNORE OTHERWISE
  def self.reset
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    end
    connection.exec("TRUNCATE comments;")
  end



end
