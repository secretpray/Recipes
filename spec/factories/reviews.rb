FactoryBot.define do
  factory :review do
    user { nil }
    recipe { nil }
    content { "MyText" }
    score { 1 }
  end
end
