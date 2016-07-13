class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups 
  has_many :user_participants, class_name: 'Participant', foreign_key: 'user_id', dependent: :nullify
  has_many :sec_user_participants, class_name: 'Participant', foreign_key: 'sec_user_id', dependent: :nullify
end
