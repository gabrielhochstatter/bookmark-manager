# feature "testing working" do
#   scenario "testing works" do
#
#     Bookmark.add('http://www.google.com')
#     Bookmark.add('http://www.facebook.com')
#     Bookmark.add('http://www.reddit.com')
#     Bookmark.add('http://www.scuba-diving.com')
#
#     visit('/')
#
#     expect(page).to have_content("http://www.google.com")
#     expect(page).to have_content("http://www.facebook.com")
#     expect(page).to have_content("http://www.reddit.com")
#     expect(page).to have_content('http://www.scuba-diving.com')
#   end
# end

feature "Bookmark Manager" do
  scenario "clicking link to add bookmark works" do
    visit('/')
    click_link('Add a bookmark')
    expect(page).to have_content 'Add your bookmark below:'
  end

  scenario "user adds a bookmark" do
    add_new_bookmark
    expect(page).to have_content 'New Bookmark'
  end

  scenario "user inputs an invalid url" do
    visit('/')
    click_link('Add a bookmark')
    fill_in('url', with: 'not a url xd')
    click_button('Add')
    expect(page).to have_content("That isn't a real url! Try again!")
  end

  scenario "user deletes a bookmark" do
    add_test_bookmark
    click_button("delete Test Bookmark")
    expect(page).not_to have_content "Test Bookmark"
  end
end
