require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks in an array' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark_1 = Bookmark.add('http://www.google.com')
      bookmark_2 = Bookmark.add('http://www.facebook.com')
      bookmark_3 = Bookmark.add('http://www.reddit.com')

      expected_bookmarks = [
        bookmark_1,
        bookmark_2,
        bookmark_3
      ]

      expect(Bookmark.all).to eq expected_bookmarks
    end
  end

  describe '.add' do
    it "adds a bookmark" do
      bookmark = Bookmark.add('http://www.tin-can-scubas.com')
      expect(Bookmark.all).to include(bookmark)
    end
  end

  describe '#delete' do
    it "deletes a bookmark" do
      bookmark_5 = Bookmark.add('http://www.scuba3000.com')
      Bookmark.delete(bookmark_5.id)
      expect(Bookmark.all).not_to include(bookmark_5)
    end
  end

  # describe '#update' do
  #   it "updates a bookmark" do
  #     bookmark_6 = Bookmark.add('www.updateme.com', 'Update Me')
  #     Bookmark.update(bookmark_6.id, 'www.updated-url.com', 'Updated')
  #     expect(bookmark_6.url).to eq('www.updated-url.com')
  #     expect(bookmark_6.title).to eq('Updated')
  #   end
  # end

  describe '#find' do
    it "finds a bookmark" do
      bookmark = Bookmark.add('www.findme.com', 'findme')
      expect(Bookmark.find(bookmark.id)).to eq bookmark
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

  describe '#==' do
    it "two bookmarks with the same id evaluate as equal" do
      bookmark_1 = Bookmark.new(1, 'http://test.com')
      bookmark_2 = Bookmark.new(1, 'http://test.com')

      expect(bookmark_1).to eq bookmark_2
    end
  end
end
