class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  scope :by_add, -> { order(created_at: :desc) }
end
