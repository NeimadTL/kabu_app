class AddForBusinessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :for_business, :boolean, default: :false
  end
end
