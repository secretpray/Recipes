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
class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :recipe
  after_destroy :remove_replies
  validates :body, presence: true, allow_blank: false

  acts_as_votable

  scope :by_add, -> { order(id: :desc) }
  scope :by_rev, -> { order(id: :asc) }
  scope :comments_for_recipe, -> (recipe_id) { where("recipe_id = ? and parent_id = 0", recipe_id).order("id") }
  scope :replies_for_recipe,  -> (recipe_id) { where("recipe_id = ? and parent_id != 0", recipe_id)
                                  .order(["parent_id", "id"]).group_by { |comment| comment["parent_id"]} }

  def reply?
    parent_id != 0
  end

  def get_parent
    Comment.find_by(id: self.parent_id)
  end

  def remove_replies
    # binding.pry
    if self.parent_id == 0
      other = Comment.where("parent_id = ?", self.id)
      other.destroy_all if other
    end
  end
end
