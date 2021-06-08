# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  recipe_id  :bigint           not null
#  content    :text
#  score      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :review do
    user { nil }
    recipe { nil }
    content { "MyText" }
    score { 1 }
  end
end
