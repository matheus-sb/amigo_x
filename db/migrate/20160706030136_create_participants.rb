class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :email
      t.boolean :accepted

      t.timestamps
    end
  end
end
