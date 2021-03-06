class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  acts_as_token_authentication_handler_for User

  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "You don't have permission to access."
    redirect_to items_path
  end

end
