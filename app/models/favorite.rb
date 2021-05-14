class Favorite < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, counter_cache: true
end
