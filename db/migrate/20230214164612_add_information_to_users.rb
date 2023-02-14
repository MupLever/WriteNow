class AddInformationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :information, :text
  end
end
