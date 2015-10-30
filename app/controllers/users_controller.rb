class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource :except => [:show, :index]
  skip_load_resource :only => [:create]

  def index
    @users = User.where.not(:id => current_user.id)
  end

  def update
    if @user.update_without_password(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role_id)
  end
end
