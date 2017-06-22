class Reply < ActiveRecord::Base
  belongs_to :ticket
  has_many :replies, as: :repliable, dependent: :destroy

  after_save :send_mailer

  def send_mailer
    TicketMailer.replied(self.ticket).deliver_now
  end
end
