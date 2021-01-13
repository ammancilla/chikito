FactoryBot.define do
  factory :shortcut do
    url { Faker::Internet.url }
    key { SecureRandom.alphanumeric(7) }
  end
end
