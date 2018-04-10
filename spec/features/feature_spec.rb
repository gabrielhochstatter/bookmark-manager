feature "testing working" do
  scenario "testing works" do
    visit('/')
    expect(page).to have_content("www.google.com")
    expect(page).to have_content("www.facebook.com")
    expect(page).to have_content("www.reddit.com")
  end
end
