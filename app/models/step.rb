class Step < ApplicationRecord
  belongs_to :recipe

  has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record
  has_rich_text :method
end
