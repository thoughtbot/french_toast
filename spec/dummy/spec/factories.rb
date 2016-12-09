FactoryGirl.define do
  factory :article do
    author "Ralph the Robot"
    body "The post body"
    sequence(:title) { |n| "Article ##{n}" }
    tags "one, two, three"
  end
end
