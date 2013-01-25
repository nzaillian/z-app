require 'pathname'

@template_root ||= File.expand_path('..', __FILE__)
@app_name ||= "[app name]"
@app_path ||= "[app path]"

MOCK = false # mock shell commands (print but do not run)

def rel_copy(full_src, rel_dest, opts={})
  
  dest_path = File.dirname(rel_dest)
  
  fname = Pathname.new(full_src).basename
  
  if !File.directory?(dest_path)
    cmd = "mkdir -p #{dest_path}"
    
    if !opts[:mock]
      run cmd
    else
      puts "mocking #{cmd}"
    end    
  end
  
  cmd = "cp #{full_src} #{dest_path}/#{fname}"
  
  if !opts[:mock]
    run cmd
  else
    puts "mocking #{cmd}"
  end

end

# copy app files
Dir["#{@template_root}/lib/z_app/**/*"].select{ |f| File.file?(f) }.each do |fname|
  rel_name = fname.gsub("#{@template_root}/lib/z_app/", "")
  rel_copy(fname, rel_name, :mock => MOCK)
end

run "rm public/index.html"
run "rm app/views/layouts/application.html.erb"
run "rm app/assets/javascripts/application.js"
run "rm app/assets/stylesheets/application.css"

route "root :to => 'home#index'"

route "match 'timezone' => 'application#session_timezone'"

# inject app name into application template
application_tpl_content = File.read("app/views/layouts/application.html.haml")
new_content = application_tpl_content.gsub("%%%APP_NAME%%%", @app_name)
application_tpl_file = File.open("app/views/layouts/application.html.haml", 'w')
application_tpl_file.write(new_content)
application_tpl_file.close

gem 'jquery-rails'

gem 'devise'

gem 'cancan'

gem 'haml-rails'

gem 'json'

gem 'bcrypt-ruby', :require => 'bcrypt'

gem 'jquery-ui-rails', '2.0.2'

gem 'mysql2'

gem 'execjs'

gem 'therubyracer'

gem 'exception_notification'

gem 'daemons', :require => 'daemons'

gem 'delayed_job_active_record', '0.3.2'

gem 'stripe', :require => 'stripe'

gem 'will_paginate'

gem 'turbolinks'

gem 'tabs_on_rails'

gem 'handles_sortable_columns'

gem 'amoeba'

gem 'capistrano'

gem 'rspec-rails'

gem 'spork-rails'  

gem 'font-awesome-rails'

gem 'formtastic'

gem 'better_errors'

# Users table migration and Devise routes
migration_timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
run "mkdir db/migrate" if !File.directory?("db/migrate")
run "cp #{@template_root}/lib/migrations/create_users.rb db/migrate/#{migration_timestamp}_create_users.rb"

rake "db:migrate"

route <<-CODE
  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :registrations => "users/registrations",
    :confirmations => "users/confirmations"
  }
CODE