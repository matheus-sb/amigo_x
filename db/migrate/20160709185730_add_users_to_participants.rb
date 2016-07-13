class AddUsersToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :user_id, :integer
    add_column :participants, :sec_user_id, :integer
  end
end
