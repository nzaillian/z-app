class Date
  def self.week_days 
    [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  end
  
  def self.week_days_str
    ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
  end

  def to_day_of_week
    Date.week_days[self.wday]
  end

  def shift_time_zone(new_time_zone)
    _working_date = DateTime.now.in_time_zone(new_time_zone)
    _adjusted = _working_date.change(:year => self.year, :month => self.month, :day => self.day, 
      :hour => self.hour, :min => self.min, :sec => self.sec)    
    return _adjusted
  end  
end

class DateTime
  def strip_date
    orig  = self
    DateTime.now.utc.change(:hour => orig.hour, :min => orig.min, :sec => orig.sec, :year => 2000, :month => 1, :day => 1)
  end

  def shift_time_zone(new_time_zone)
    _working_date = DateTime.now.in_time_zone(new_time_zone)
    _adjusted = _working_date.change(:year => self.year, :month => self.month, :day => self.day, 
      :hour => self.hour, :min => self.min, :sec => self.sec)    
    return _adjusted
  end

  def pretty_relative(current_datetime)
    if self.to_date === current_datetime.to_date
      date_str = "Today"
    else
      _tomorrow = (current_datetime + 1.day)

      if self.to_date === _tomorrow.to_date
        date_str = "Tomorrow"
      else
        date_str = self.strftime('%m/%d/%Y')
      end      
    end
    return "#{date_str} at #{self.strftime('%I:%M %p')}"
  end

  def with_minutes(minutes)
    
    if minutes.class == String
      minutes = minutes.to_i
    end

    hours = (minutes / 60).floor
    mins = minutes % 60
    return self.change(:hour => hours, :min => mins)
  end
end