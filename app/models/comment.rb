class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :recipe
  validates :body, presence: true, allow_blank: false

  acts_as_votable

  scope :by_add, -> { order(created_at: :desc) }
end
