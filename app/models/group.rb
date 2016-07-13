class Group < ApplicationRecord
	belongs_to :user
	has_many :participants

  def self.raffle(group)  	
  	raise 'Este grupo já foi sorteado!' if group.raffled

  	participants = group.participants.where('user_id IS NOT NULL')

    raise 'O sorteio só pode ser realizado com três ou mais participantes!' if participants.count < 3  

    copy = participants.dup
	
    array = []
    while true do
      copy = copy.shuffle
      array = participants.zip(copy)
      
      break if array.all? do |(p, f)|
        p != f
      end
    end
    # user = User.find(7)
    array.each do |(p, f)|
      p.update(sec_user: f.user)
    end
   
    # participants.each do |u|
    #   if u.raffled?
    #     UserMailer.notify2(u).deliver_now
    #   else
    #     UserMailer.notify(u).deliver_now
    #   end
    # end
     
    group.update(raffled: true)
  end	
end
