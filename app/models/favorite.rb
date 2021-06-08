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
class Favorite < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, counter_cache: true
end
