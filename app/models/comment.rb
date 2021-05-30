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

  # def self.comments_for_recipe(recipe_id)
    # SELECT "comments".* FROM "comments" WHERE (recipe_id = 20 and parent_id = 0) ORDER BY id
    # Comment.where("recipe_id = ? and parent_id = 0", recipe_id).order("id")
  # end

  # def self.replies_for_recipe(recipe_id)
    # SELECT "comments".* FROM "comments" WHERE (recipe_id = 20 and parent_id = 0) ORDER BY parent_id, id
    # Comment.where("recipe_id = ? and parent_id != 0", recipe_id).order(["parent_id", "id"]).group_by { |comment| comment["parent_id"]}
  # end
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
