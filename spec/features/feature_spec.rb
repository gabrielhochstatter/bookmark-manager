feature "testing working" do
  scenario "testing works" do
    visit('/')
    expect(page).to have_content("testing 123")
  end
end
