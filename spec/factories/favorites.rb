# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  recipe_id  :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :favorite do
    recipe { nil }
    user { nil }
  end
end
