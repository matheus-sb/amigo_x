class ParticipantMailer < ApplicationMailer

	def participant_confirmation(participant)
      @participant = participant
      mail(to: @participant.email, subject: 'Por favor, confirme a sua participação no amigo secreto')
	end
end