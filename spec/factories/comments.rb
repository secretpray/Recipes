# == Schema Information
#
# Table name: comments
#
#  id                      :bigint           not null, primary key
#  body                    :text
#  user_id                 :bigint           not null
#  recipe_id               :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  parent_id               :integer          default(0)
#
FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    recipe { nil }
  end
end
