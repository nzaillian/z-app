module UiHelper
  def titled_field(title, value, opts={})
    classes = "titled-field"
    classes += " #{opts[:class]}" if opts[:class]
    render_to_string(:partial => '/common/titled_field', 
      :locals => {:classes => classes, :title => title, :value => value}).html_safe
  end
end