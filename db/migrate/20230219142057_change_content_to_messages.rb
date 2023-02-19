class ChangeContentToMessages < ActiveRecord::Migration[7.0]
  def change
    change_column :messages, :content, :text, null:false
  end
end
