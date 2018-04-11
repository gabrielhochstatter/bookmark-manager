def add_test_bookmark
  visit('/')
  click_link('Add a bookmark')
  fill_in('title', with: 'Test Bookmark')
  fill_in('url', with: 'http://www.testbookmark.com')
  click_button('Add')
end

def add_new_bookmark
  visit('/')
  click_link('Add a bookmark')
  fill_in('title', with: 'New Bookmark')
  fill_in('url', with: 'http://www.newbookmark.com')
  click_button('Add')
end
