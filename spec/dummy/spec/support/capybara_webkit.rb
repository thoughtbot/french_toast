Capybara.javascript_driver = :webkit
Capybara.server = :puma

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end
