class AddGroupIdToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :group_id, :integer
  end
end
