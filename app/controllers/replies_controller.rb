class RepliesController < ApplicationController
  def create
    @ticket = get_ticket
    @reply = @ticket.replies.create(reply_params)
    if @reply.save
      @reply.update_attribute(:from, current_user.email)
      flash[:success] = "Reply was saved!"
    else
      flash.now[:danger] = "error"
    end
    redirect_to ticket_path(@ticket)
  end

  private

  def get_ticket
    @ticket = Ticket.find_by_id(params[:ticket_id]) if params[:ticket_id]
  end

  def reply_params
    params.require(:reply).permit(:text)
  end
end
