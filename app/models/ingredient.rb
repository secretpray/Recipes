# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  content    :text
#  recipe_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Ingredient < ApplicationRecord
  belongs_to :recipe

  has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record
  has_rich_text :content
end
