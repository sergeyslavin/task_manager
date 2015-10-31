class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource
  skip_load_resource :only => [:create]

  def index
    @users = User.users_without_me(current_user, [:id, :email, :last_sign_in_at, :role_id])
  end

  def update
    respond_with do |format|
      if @user.update_without_password(user_params)
        format.html { redirect_to @user, notice: "Successfully updated User." }
        format.json { render :show, status: :created, location: @user }        
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_with do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
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
