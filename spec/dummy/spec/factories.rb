FactoryGirl.define do
  factory :article do
    author "Ralph the Robot"
    body "The post body"
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:title) { |n| "Article ##{n}" }
    tags "one, two, three"
  end
end
