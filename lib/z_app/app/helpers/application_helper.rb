module ApplicationHelper
  include DeviseHelper

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def parse_time_str(time_str)
    utc = ActiveSupport::TimeZone.new("UTC")
    begin
      utc.parse(time_str)
    rescue TypeError
      nil
    end
  end  

  def current_layout
    layout = controller.send(:_layout)
    if layout.instance_of? String
      layout
    else
      File.basename(layout.identifier).split('.').first
    end
  end

  def render_alerts(options={})
    render_to_string(:partial => "/common/alerts").html_safe
  end

  def render_validation_errors(record)
    if record.errors.any?
      err_body = render_to_string(:partial => '/common/validation_errors', 
        :locals => {:record => record}).html_safe
      flash.now[:validation_errors] = err_body
    end
    ""
  end

  def render_form_errs(record)
    if record.errors.any?
      html = render_to_string(:partial => '/common/validation_error_box.html.haml',
        :locals => {:record => record})
      html.html_safe
    else
      ""
    end
  end

  def currency_formatted(val, opts={})
    if opts[:dollar] == true
      "$%.2f" % val
    else
      "%.2f" % val
    end
  end

  def partial_opt(assigns, key, default)
    if assigns.has_key?(key) and assigns[key] != nil
      assigns[key]
    else
      default
    end
  end

  # return expr if object is defined, else return default
  def if_def(obj, meth, *params)
    if defined?(obj) and obj != nil
      obj.send(meth, *params)
    end
  end
end