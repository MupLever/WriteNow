class AddArrayUserIdToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :users, :integer, array: true
    add_index :matches, :users
    remove_column :matches, :user_id, :integer
  end
end
