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
require "test_helper"

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
