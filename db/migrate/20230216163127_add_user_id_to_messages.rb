class AddUserIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :user
    add_foreign_key :messages, :users
  end
end
