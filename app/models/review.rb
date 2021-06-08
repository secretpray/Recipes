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
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_rich_text :content
  
  validates :score, presence: true
end
