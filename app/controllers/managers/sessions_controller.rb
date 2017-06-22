class Managers::SessionsController < ApplicationController
  before_action :logged_in_manager, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tickets_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to managers_login_path
  end
end
