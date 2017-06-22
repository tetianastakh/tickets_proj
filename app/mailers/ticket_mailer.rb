class TicketMailer < ApplicationMailer
  default from: "ticketstestapp@gmail.com"

  def ticket_created(ticket)
    @ticket = ticket
    mail to: ticket.from_email, subject: "Ticket created!"
  end

  def replied(ticket)
    @ticket = ticket
    mail to: ticket.from_email, subject: "Reply on ticket!"
  end
end
