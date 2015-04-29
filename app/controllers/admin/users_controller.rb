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


  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)

  #       if @user.save
  #         redirect_to users_path, notice: "#{@user.full_name} was submitted successfully!"
  #       else
  #         render :new
  #       end
  # end

  private

  def ensure_admin
    if !current_user
      flash[:alert] = 'You need to log in!'
      redirect_to '/sessions/new'
    elsif !current_user.admin
      flash[:alert] = "You are not an admin!"
      redirect_to '/'
    end
  end


end
