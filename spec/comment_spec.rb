require 'comment'
require "bookmark"
# require 'pg'
#
# connection = PG.connect(dbname: 'bookmark_manager_test')
#
# connection.exec("TRUNCATE comments;")

describe Comment do
  describe '#all' do
    it "returns an array of all the comments" do
      Comment.reset
      bookmark = Bookmark.add('test', 'test.com')
      comment_1 = Comment.add('just a comment', bookmark.id)
      comment_2 = Comment.add('another comment', bookmark.id)
      comment_3 = Comment.add('no one knows what its like to be a comment', bookmark.id)

      expected_comments = [comment_1, comment_2, comment_3]

      expect(Comment.all).to eq expected_comments
    end
  end

end
