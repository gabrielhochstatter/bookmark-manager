feature "testing working" do
  scenario "testing works" do

    Bookmark.add('http://www.google.com')
    Bookmark.add('http://www.facebook.com')
    Bookmark.add('http://www.reddit.com')
    Bookmark.add('http://www.scuba-diving.com')

    visit('/')

    expect(page).to have_content("http://www.google.com")
    expect(page).to have_content("http://www.facebook.com")
    expect(page).to have_content("http://www.reddit.com")
    expect(page).to have_content('http://www.scuba-diving.com')
  end
end

feature "add a bookmark" do
  scenario "clicking link to add bookmark works" do
    visit('/')
    click_link('Add a bookmark')
    expect(page).to have_content 'Add your bookmark below:'
  end

  scenario "user adds a bookmark" do
    visit('/')
    click_link('Add a bookmark')
    fill_in('url', with: 'http://www.newbookmark.com')
    click_button('Add')
    expect(page).to have_content 'http://www.newbookmark.com'
  end
end
