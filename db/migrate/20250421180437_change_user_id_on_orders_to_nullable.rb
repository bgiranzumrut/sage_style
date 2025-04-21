class ChangeUserIdOnOrdersToNullable < ActiveRecord::Migration[7.0] # or [6.1] based on your version
  def change
    change_column_null :orders, :user_id, true
  end
end
