class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.decimal :price

      t.timestamps null: false
    end
  end
end
