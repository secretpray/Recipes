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
require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
