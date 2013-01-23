class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :render_to_string, :number_with_precision

  include ApplicationHelper

  before_filter :attr_initialize

  def home

  end

  def session_timezone
    if params[:offset]
      session[:timezone_offset] = params[:offset].to_i * -60
      session[:timezone] = ActiveSupport::TimeZone[session[:timezone_offset]]
    end
    render :nothing => true
  end

  def render_err(params={})
    @key, @obj = params[:key], params[:obj]
    respond_to do |format|
      format.json { render :json => {:status => 'err', @key => @obj} }
      format.html { render :template => 'common/resource_err', :layout => 'application' }
    end
  end

  def render_401
    err_str = 'You have attempted to modify a resource for which you have insufficient privileges.'
    respond_to do |format|
      format.html { render(:text => err_str, :status => '401') and return }
      format.json { render :json => { :status => 401, :message => err_str }.to_json }
    end
  end

  def render_404(exc)
    logger.debug(exc)
    err_str = 'The resource you have requested could not be found on our servers.'
    respond_to do |format|
      format.html { render '/common/404', :layout => 'application' }
      format.json { render :json => { :status => 404, :message => err_str }.to_json }
    end
  end

  def page_heading(val)
    @_page_heading = val
  end

  private

  def log_error(message)
    Rails.logger.error(message)
  end

  def log_debug(message)
    Rails.logger.debug(message)
  end

  def attr_initialize
    @url_helpers = Rails.application.routes.url_helpers
  end

  rescue_from ActionController::RoutingError do |exception|
    render_404(exception)
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_404(exception)
  end

  rescue_from CanCan::AccessDenied do |exception|
    render_401
  end  

  def bounce_to_landing
    unless params[:controller] == 'home' and params[:action] == 'landing'
      redirect_to :controller => 'home', :action => 'landing'
    end
  end

  def authenticate_jobs_user
    if params[:job_user].blank? or params[:job_user] != Rails.application.config.job_user_token
      raise CanCan::AccessDenied
    end
  end  
end
