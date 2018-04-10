require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks in an array' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES ('www.google.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('www.facebook.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('www.reddit.com');")

      expected_bookmarks = [
        'www.google.com',
        'www.facebook.com',
        'www.reddit.com'
      ]

      expect(Bookmark.all).to eq expected_bookmarks
    end
  end
end
