# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("user")
#  first_name             :string
#  last_name              :string
#  username               :string
#  about                  :text
#  birthday               :date
#  status                 :string           default("active"), not null
#  recipes_count          :integer          default(0), not null
#  favorites_count        :integer          default(0), not null
#  comments_count         :integer          default(0), not null
#  language               :string
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
