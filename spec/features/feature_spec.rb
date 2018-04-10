feature "testing working" do
  scenario "testing works" do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'www.google.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'www.facebook.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'www.reddit.com');")

    visit('/')

    expect(page).to have_content("www.google.com")
    expect(page).to have_content("www.facebook.com")
    expect(page).to have_content("www.reddit.com")
  end
end

feature "add a bookmark" do
  scenario "clicking link to add bookmark works" do
    visit('/')
    click_link('Add a bookmark')
    expect(page).to have_content 'Add your bookmark below:'
  end
end
