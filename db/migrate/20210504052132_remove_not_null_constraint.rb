class RemoveNotNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :recipes, :description, true
  end
end
