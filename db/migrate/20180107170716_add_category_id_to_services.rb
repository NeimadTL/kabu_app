class AddCategoryIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :category_id, :integer
  end
end
