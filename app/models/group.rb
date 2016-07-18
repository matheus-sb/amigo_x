class Group < ApplicationRecord
	belongs_to :user
	has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: { message: 'O nome deve ser preenchido' }

  def raffle
  	raise 'Este grupo já foi sorteado!' if raffled

  	partics = participants.where('user_id IS NOT NULL')

    raise 'O sorteio só pode ser realizado com três ou mais participantes confirmados!' if partics.count < 3  

    copy = partics.dup
	
    array = []
    while true do
      copy = copy.shuffle
      array = partics.zip(copy)
      
      break if array.all? do |(p, f)|
        p != f
      end
    end
    
    array.each do |(p, f)|
      p.update(sec_user: f.user)
    end
   
    # need send e-mail
      
    update(raffled: true)
  end	
end
