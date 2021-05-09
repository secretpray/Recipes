class Tag < ApplicationRecord
  has_many :taggings
  has_many :recipes, through: :taggings

  validates :name, presence: true

  def self.counts
    # self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
    Tag.left_joins(:recipes).group(:id).order('COUNT(recipes) DESC').reverse.take(12)
  end
end
