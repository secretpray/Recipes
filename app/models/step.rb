# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  method     :text
#  recipe_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Step < ApplicationRecord
  belongs_to :recipe

  has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record
  has_rich_text :method
end
