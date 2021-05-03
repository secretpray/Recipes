class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :body, presence: true, allow_blank: false

  scope :by_add, -> { order(created_at: :desc) }
end
