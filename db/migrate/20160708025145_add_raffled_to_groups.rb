class AddRaffledToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :raffled, :boolean
  end
end
