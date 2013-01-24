class Users::SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication
  
  def after_sign_in_path_for(resource)
    if params[:next].present?
      params[:next]
    else
      root_path
    end
  end
end