class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
  end

  def show_user
    @user = User.find(params[:user_id])
  end
  def edit
      @user.avatar.attach(params[:avatar])
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

   def update
 @user = User.find(params[:id])
 if @user.update_attributes(secure_params)
  redirect_to users_path, :notice => "User updated."
 else
  redirect_to users_path, :alert => "Unable to update user."
 end
end
 
 def ban
    @user = User.find(params[:user_id])
    if @user.ban?
      @user.update_attribute(:ban, false)
      redirect_to users_path, :notice => "User unbanned."
    else
      @user.update_attribute(:ban, true)
      redirect_to users_path, :notice => "User banned."
    end	
end

  def mod
    @user = User.find(params[:user_id])
    if @user.mod?
      @user.update_attribute(:mod, false)
      redirect_to users_path, :notice => "User unmoded."
    else
      @user.update_attribute(:mod, true)
      redirect_to users_path, :notice => "User moded."
    end 
  end

  def admin
    @user = User.find(params[:user_id])
    if @user.admin?
      @user.update_attribute(:admin, false)
      redirect_to users_path, :notice => "User unadmined."
    else
      @user.update_attribute(:admin, true)
      redirect_to users_path, :notice => "User admined."
    end 
  end
end