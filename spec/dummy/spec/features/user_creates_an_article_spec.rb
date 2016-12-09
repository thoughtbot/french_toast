require "rails_helper"

feature "User creates an article", :js do
  scenario "asynchronously" do
    visit root_path
    click_link "Add article"

    fill_in :article_title, with: "True Facts"
    fill_in :article_body, with: "This is real news"
    fill_in :article_author, with: "Bannon"
    fill_in :article_tags, with: "facts, news, totally real"
    click_button "Create article"

    expect(page).to have_content "Articles"
    expect(page).not_to have_content "Your article has been processed"

    ActiveJob::Base.queue_adapter.run_jobs

    expect(page).to have_content "Your article has been processed"
  end
end
