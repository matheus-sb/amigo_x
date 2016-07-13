class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :address
      t.string :city

      t.timestamps
    end
  end
end
