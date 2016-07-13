class AddConfirmTokenToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :confirm_token, :string
  end
end
