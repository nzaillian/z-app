smtp_settings = {
  :address              => "mail.domain.com",
  :port                 => 587,
  :domain               => 'domain.com',
  :user_name            => 'info@domain.com',
  :password             => 'password',
  :authentication       => :login,
  :enable_starttls_auto => true,
  :openssl_verify_mode => 'none'
}


ActionMailer::Base.smtp_settings = smtp_settings

if Rails.env.development? or Rails.env.test?
  ActionMailer::Base.delivery_method = :smtp
  
  url_opts = {
    :host => Rails.application.config.domain,
    :port => Rails::Server.new.options[:Port]
  }

  Rails.application.config.action_mailer.default_url_options = url_opts
  Rails.application.config.action_controller.default_url_options = url_opts
  ActionMailer::Base.default_url_options = url_opts
end

if Rails.env.production?
  url_opts = {
    :host => Rails.application.config.domain
  }  

  Rails.application.config.action_mailer.default_url_options = url_opts
  Rails.application.config.action_controller.default_url_options = url_opts
  ActionMailer::Base.default_url_options = url_opts
end

Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?