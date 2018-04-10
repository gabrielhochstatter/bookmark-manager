require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks in an array' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      Bookmark.add('http://www.google.com')
      Bookmark.add('http://www.facebook.com')
      Bookmark.add('http://www.reddit.com')

      expected_bookmarks = [
        'http://www.google.com',
        'http://www.facebook.com',
        'http://www.reddit.com'
      ]

      expect(Bookmark.all).to eq expected_bookmarks
    end
  end

  describe '.add' do
    it "adds a bookmark" do
      Bookmark.add('http://www.tin-can-scubas.com')
      expect(Bookmark.all).to include('http://www.tin-can-scubas.com')
    end
  end

  describe '.is_valid_url?' do
    it "returns false if url is invalid" do
      expect(Bookmark.is_valid_url?("not a url")).not_to be
    end

    it "returns true if url is valid" do
      expect(Bookmark.is_valid_url?("http://www.validurl.com")).to be
    end
  end
end
