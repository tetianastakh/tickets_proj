require 'rake'  
load File.join(Rails.root, 'lib', 'tasks', 'elasticsearch.rake')

class TicketsController < ApplicationController
  before_action :logged_in_manager, only: [:index]

  def index
    if params[:search].blank?
      @tickets = Ticket.all.order('created_at desc')
    else
      search
    end
  end

  def show
    @ticket = get_ticket
    @reply = @ticket.replies.build
    @replies = @ticket.replies.order('created_at desc')
  end

  def new
    current_user ? (redirect_to tickets_path) : @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      assing_uniq_identifier(@ticket)
      Rake::Task['elasticsearch:sync_elasticsearch'].invoke
      TicketMailer.ticket_created(@ticket).deliver_now
      flash[:notice] = "Ticket was saved"
    else
      flash[:error] = @ticket.errors.full_messages.to_sentence
    end
    redirect_to new_ticket_path
  end

  def edit
    @ticket = get_ticket
  end

  def update
    @ticket = get_ticket
    if @ticket.update_attributes(ticket_params)
      TicketMailer.ticket_created(@ticket).deliver_now
      flash[:notice] = "Ticket was updated"
      redirect_to ticket_path(@ticket)
    else
      flash[:error] = @ticket.errors.full_messages.to_sentence
      redirect_to edit_ticket_path(@ticket)
    end
  end

  private

  def search
    @tickets = Ticket.search(params[:search]).results
    if @tickets.count == 1
      ticket = @tickets.first
      redirect_to ticket_path(ticket["_id"])
    end
  end

  def ticket_params
    params.require(:ticket).permit(:subject, :body, :uniq_identifier, :from_name, :from_email)
  end

  def get_ticket
    @ticket = Ticket.find(params[:id])
  end

  def assing_uniq_identifier(ticket)
    ticket.update_attribute(:uniq_identifier, random_id)
  end

  def random_id
    random_string + "-" + random_int_string + "-" + random_string + "-" + random_int_string
  end

  def random_string
    3.times.map { [*'a'..'z'].sample }.join.upcase
  end

  def random_int_string
    3.times.map { [*'0'..'9'].sample }.join
  end
end
