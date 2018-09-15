class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to :products
    else
      redirect_to :sign_in
    end
  end

  def destroy
     session[:user_id] = nil
    redirect_to :sign_in
  end

end
