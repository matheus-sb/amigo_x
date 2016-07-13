class Participant < ApplicationRecord
  before_create :confirmation_token, unless: :confirm_token?

  validates :email,
    format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
      message: "Informe um e-mail válido" 
    },
    uniqueness: { scope: :group_id,
    message: "Você já adicionou este e-mail para este grupo" }

  belongs_to :group
  belongs_to :user, class_name: 'User', optional: true
  belongs_to :sec_user, class_name: 'User', optional: true
  
  def confirm_participation(user)
    self.user = user
    self.confirm_token = nil
    save!(validate: false)
  end

  private
    def confirmation_token
      self.confirm_token = SecureRandom.uuid
    end
end
