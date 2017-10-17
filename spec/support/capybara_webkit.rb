Capybara.javascript_driver = :webkit
Capybara.register_server :silent_puma do |app, port, host, options = {}|
  require "rack/handler/puma"
  Rack::Handler::Puma.run(
    app,
    {
      Host: host,
      Port: port,
      Silent: true,
      Threads: "0:4",
      daemon: false,
      workers: 0,
    }.merge(options),
  )
end
Capybara.server = :silent_puma

Capybara::Webkit.configure(&:block_unknown_urls)
