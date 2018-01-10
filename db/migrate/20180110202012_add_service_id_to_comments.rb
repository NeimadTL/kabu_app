class AddServiceIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :service_id, :integer, index: true
  end
end
