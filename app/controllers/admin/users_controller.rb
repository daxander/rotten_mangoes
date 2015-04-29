class Admin::UsersController < ApplicationController
  before_filter :ensure_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
   @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
  end


  def preview_mode
    session[:user_id] = params[:id]
    redirect_to movies_path
  end



  protected


  def ensure_admin
    if !current_user
      flash[:alert] = 'You need to log in!'
      redirect_to '/sessions/new'
    elsif !session[:actual_id]
      flash[:alert] = "You are not an admin!"
      redirect_to '/'
    end
  end


end
