require "rails_helper"

RSpec.feature "user sees flash from created article" do
  scenario "asynchronously", :js do
    title = "True Facts"
    processed_content = "'#{title}' article has been successfully created"
    visit root_path
    click_link "Add"

    fill_in :article_title, with: title
    fill_in :article_body, with: "This is real news"
    fill_in :article_author, with: "Bannon"
    fill_in :article_tags, with: "facts, news, totally real"
    fill_in :article_email, with: "author@example.com"
    click_button "Create article"

    expect(page).to have_content "Articles"
    within ".french-toast-c-content" do
      expect(page).not_to have_css("p")
      expect(page).not_to have_content(processed_content)
    end

    perform_enqueued_jobs

    within ".french-toast-c-content" do
      expect(page).to have_css("p")
      expect(page).to have_content(processed_content)
    end
    expect(FrenchToast::LastNotification.all).to be_empty
  end

  scenario "synchronously" do
    title = "True Facts"
    processed_html = "<p>'#{title}' article has been successfully created</p>"
    visit root_path
    click_link "Add article"

    fill_in :article_title, with: title
    fill_in :article_body, with: "This is real news"
    fill_in :article_author, with: "Bannon"
    fill_in :article_tags, with: "facts, news, totally real"
    fill_in :article_email, with: "author@example.com"
    click_button "Create article"

    expect(page).to have_content "Articles"
    expect(page).to have_content "Refresh page for updates"
    expect(page.html).not_to include processed_html

    perform_enqueued_jobs

    visit root_path

    expect(page.html).to include processed_html
    expect(FrenchToast::LastNotification.all).to be_empty
  end
end
