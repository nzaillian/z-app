module UiHelper
  def titled_field(title, value, opts={})
    classes = "titled-field"
    classes += " #{opts[:class]}" if opts[:class]
    render_to_string(:partial => '/common/titled_field', 
      :locals => {:classes => classes, :title => title, :value => value}).html_safe
  end

  def datepicker(form_builder, attr_name, opts={})
    if opts[:label]
      label = opts[:label]
    else
      label = attr_name.to_s.gsub("_", " ").split.map(&:capitalize).join(" ")
    end

    classes = "datepicker-input"
    if opts[:class]
      classes += " " + opts[:class]
    end
    render_to_string(:partial => '/common/datepicker',
      :locals => {:form_builder => form_builder, 
        :obj => form_builder.object, :attr_name => attr_name, 
        :label => label, :classes => classes}).html_safe
  end  
end