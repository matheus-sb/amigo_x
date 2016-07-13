class RemoveSomeColumnsFromParticipants < ActiveRecord::Migration[5.0]
  def change
    remove_column :participants, :accepted, :boolean
  end
end
