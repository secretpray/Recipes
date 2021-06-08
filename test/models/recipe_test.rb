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
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
