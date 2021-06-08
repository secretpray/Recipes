# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string
#
class Category < ApplicationRecord    
  has_ancestry
  # has_ancestry cache_depth: true
  has_many :recipes, dependent: :destroy
  validates :name, presence: true

end
