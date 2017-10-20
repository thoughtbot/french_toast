# French Toast
[![Build Status](https://travis-ci.org/thoughtbot/french_toast.svg?branch=master)](https://travis-ci.org/thoughtbot/french_toast)
[![Code Climate](https://codeclimate.com/github/thoughtbot/french_toast/badges/gpa.svg)](https://codeclimate.com/github/thoughtbot/french_toast)

Communicate information about background jobs in Rails seamlessly.

FrenchToast attempts to streamline some [progressive enhancement](https://en.wikipedia.org/wiki/Progressive_enhancement) by providing a simple and opinionated interface. In order to best take advantage of this, it is important to render that information on the backend. This allows FrenchToast to figure out the best possible communication stream, by starting the most basic functionality and slowly building up to more enhanced features.

With `FrenchToast` it will:

1. Communicate through websockets
2. If that is unavailable, communicate on next page refresh
3. If the user hasn't seen the content, send them an email

## Installation

- Add the `FrenchToast` gem to your Gemfile:

  ```
  gem "french_toast"
  ```

- Run `bundle install` from your shell.

- Generate migrations so ``FrenchToast`` can render information when javascript isn't available.

```
rails generate french_toast:install
rake db:migrate
```

## Usage

### General

The `#french_toast` helper provides the simplest interface for `FrenchToast`. It can be used, for example, on the `application` layout.

```erb
# application.html.erb
<%= french_toast %>
```

`FrenchToast` looks for templates by default in the `views/french_toast` folder.

```erb
# _foo.html.erb
<div>You'll see me eventually! <%= your_name %></div>
```

Use `#notify` with the name of the template to be rendered to render that template on the page.

```ruby
# something_job.rb
class SomethingJob
  def perform
    FrenchToast.notify("foo", locals: { your_name: "Jim-bob" })
  end
end
```

Where you specified `#french_toast` you will see the `foo.html.erb` template fully rendered using the best channel available to your user.

### Specifying sections

`FrenchToast` gives you the option to be more specific about what kind of content should be rendered.

Provide a namespace to `#french_toast` helper

```erb
# posts/index.html.erb
<%= french_toast :post %>
```

Referencing a template the same way, provide `name` attribute to `#notify` will render the template only where it is namespaced.

```ruby
#... something_job.rb
def perform
  FrenchToast.notify("foo", name: :post)
end
```

Where `#french_toast` was specified with `:post`, the `foo.html.erb` template will be rendered.

### Synchronous render control

`FrenchToast` by default will store information in your database to be displayed later if a user is unable to receive information asynchronously. This can be prevented if there is already a faster, simpler way to communicate information on page load.

For example, `FrenchToast` is being used to update a list of posts on a page through websockets, but there is already a code to render each post on the server. You can prevent `FrenchToast` from storing that content on the server.

On the `#french_toast` helper you can specify the `synchronous` attribute, which helps specify the type of communication allowed.

```erb
<%= french_toast :post, synchronous: false %>
```

### Granular template control

`FrenchToast` by default assumes HTML templates are being rendered on the page. There are times that require more granular control of the template because the information being sent is not HTML.

A custom template can be specified and referenced using the `template` attribute on the `#french_toast` helper.

```erb
<%= french_toast :text, template: "text_only" %>
```

Create a template in `french_toast/templates` and use the `#french_toast_tag` helper to generate the necessary HTML that can be identified by `FrenchToast`.

```erb
# _text_only.html.erb
<div class="my-own-thing" >
  <%= french_toast_tag :p %>
</div>

```

## Contributing

See the [CONTRIBUTING] document.
Thank you, [contributors]!

  [CONTRIBUTING]: CONTRIBUTING.md
  [contributors]: https://github.com/thoughtbot/french_toast/graphs/contributors

## License

French Toast is Copyright (c) 2016-2017 thoughtbot, inc.
It is free software, and may be redistributed
under the terms specified in the [LICENSE] file.

  [LICENSE]: LICENSE.md

## About

[<img src="http://presskit.thoughtbot.com/images/signature.svg" width="250" alt="thoughtbot logo">][thoughtbot]

French Toast is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community]
or [hire us][hire] to help build your product.

  [thoughtbot]: https://thoughtbot.com?utm_source=github
  [community]: https://thoughtbot.com/community?utm_source=github
  [hire]: https://thoughtbot.com/hire-us?utm_source=github
