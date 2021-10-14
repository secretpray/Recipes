# == Schema Information
#
# Table name: recipes
#
#  id                   :bigint           not null, primary key
#  title                :string           not null
#  description          :text
#  user_id              :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  slug                 :string
#  category_id          :integer
#  serves               :integer
#  time_prep            :time
#  time_cook            :time
#  time_ps              :text
#  nutrion_ps_kcal      :integer
#  nutrion_ps_fat       :integer
#  nutrion_ps_saturates :integer
#  nutrion_ps_carbs     :integer
#  nutrion_ps_sugar     :integer
#  nutrion_ps_fibre     :integer
#  nutrion_ps_protein   :integer
#  nutrion_ps_salt      :integer
#  prep_easy            :boolean
#  gluten_free          :boolean
#  peanut_free          :boolean
#  sugar_free           :boolean
#  salt_free            :boolean
#  kosher               :boolean
#  vegan                :boolean
#  vegetarin            :boolean
#
class Recipe < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model

  belongs_to :user, counter_cache: true
  belongs_to :category
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :recipe_image
  has_many_attached :step_images

  friendly_id :title, use: :slugged

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank

  MAX_TITLE_LENGTH = 120
  MAX_DESCRIPTION_LENGTH = 320

  validates :title, :description, presence: true
  validates :title, length: { maximum: MAX_TITLE_LENGTH }
  validates :description, length: { maximum: MAX_DESCRIPTION_LENGTH }
  validate :image_type

  scope :by_add, -> { order(created_at: :desc) } # double
  scope :by_user, -> { order(user_id: :asc) }
  scope :favorited_by, -> (email) { joins(:favorites).where(favorites: { user: User.where(email: email)}) }
  # pg_search_scope :global_search, against: [:title, :description], using: { tsearch: { prefix: true } }
  pg_search_scope :global_post_search, against: [:title, :description], using: { tsearch: { prefix: true } }



  def self.recent
    order('created_at desc')
  end

  def to_s
    title
  end

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end

  def self.best
    left_joins(:favorites).group(:id).order('COUNT(favorites) DESC')
  end

  def thumbnail input
    return self.step_images[input].variant(resize: '300x300!').processed
  end

  def image_type
    if recipe_image.present?
      errors.add(:recipe_image, 'needs to be a JPEG or PNG') unless recipe_image.content_type.in?(%('image/jpeg image/png'))
    end

    if step_images.any?
      step_images.each do |image|
        errors.add(:step_images, 'needs to be a JPEG or PNG') unless image.content_type.in?(%('image/jpeg image/png'))
      end
    end
  end

  def in_favorite? user
    Favorite.where(recipe: self, user: user).any?
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    names = names.join('') if names.is_a? Enumerable

    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).recipes
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def only_replies
      self.comments.where("parent_id != 0")
  end

  def only_comments
      self.comments.where("parent_id = 0")
  end

  def self.parse_search_params(params, result)
    case
    when !params[:content].blank?
      @recipes = result.includes(:category, :user)
                    .where('title ILIKE ? OR description ILIKE ?', "%#{params[:content]}%", "%#{params[:content]}%")
    when !params[:ingredient].blank?
      @ingredients = Ingredient.joins(:action_text_rich_text)
                          .where("action_text_rich_texts.body LIKE ?", "%#{params[:ingredient]}%")
      @recipes = Recipe.joins(:ingredients).where("ingredients.id" => @ingredients)
    when !params[:step].blank?
      @steps = Step.joins(:action_text_rich_text)
                          .where("action_text_rich_texts.body LIKE ?", "%#{params[:step]}%")
      @recipes = Recipe.joins(:steps).where("steps.id" => @steps)
    else
      @recipes = result.includes(:category, :user)
    end
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at at time zone 'utc' at time zone 'Europe/Amsterdam')")
  end
end
