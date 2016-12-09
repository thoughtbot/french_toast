require "rails_helper"

feature "user notified", :js do
  scenario "when websocket connection not available uses email" do
    visit root_path
    submit_article_through_form

    # Close the browser session
    Capybara.reset_sessions!

    ActiveJob::Base.queue_adapter.run_jobs

    email = ActionMailer::Base.deliveries.first
    expect(email).to be_present
    expect(email).to deliver_to(email_address)
    expect(email).to have_body_text(/Your article has been processed./)
  end

  scenario "when websocket connection is available does not use email" do
    allow(ActionCable.server).to receive(:broadcast).and_call_original
    visit root_path
    submit_article_through_form

    ActiveJob::Base.queue_adapter.run_jobs

    expect(ActionMailer::Base.deliveries.first).to be_nil
  end

  scenario "when other websocket connections for other sessions exist they are not notified" do
    allow(ActionCable.server).to receive(:broadcast).and_call_original
    visit root_path
    submit_article_through_form

    # Close the browser session
    Capybara.reset_sessions!
    # Create a new browser session with a new session key?
    visit root_path

    ActiveJob::Base.queue_adapter.run_jobs

    email = ActionMailer::Base.deliveries.first
    expect(email).to be_present
    expect(email).to deliver_to(email_address)
    expect(email).to have_body_text(/Your article has been processed./)
  end

  def submit_article_through_form
    click_link "Add article"

    fill_in :article_title, with: "True Facts"
    fill_in :article_body, with: "This is real news"
    fill_in :article_author, with: "Bannon"
    fill_in :article_tags, with: "facts, news, totally real"
    fill_in :article_email, with: email_address
    click_button "Create article"
  end

  def email_address
    "author@example.com"
  end
end
