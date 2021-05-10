class AddColumnAboutAndBirthdayToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :about, :text
    add_column :users, :birthday, :date
  end
end
