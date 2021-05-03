FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    recipe { nil }
  end
end
