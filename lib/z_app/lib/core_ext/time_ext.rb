module CoreExt
  module TimeExt
    include ActsAsReloadable
    
    def dayspan(end_date, opts={})      
      base_time = midnight
      end_time = end_date.midnight

      items = []

      cur = base_time

      while cur <= end_time
        items << cur
        cur += 1.day
      end

      items
    end

    def upto(end_time, opts={})
      interval = opts[:interval] || 15.minutes
      round = (true if opts[:round] == nil) || opts[:round]

      if round
        base_time = self.round(interval)
        end_time = end_time.round(interval)
      end

      items = []

      cur = base_time

      while cur <= end_time
        items << cur
        cur += interval
      end

      items
    end

    def round(seconds = 60)
      Time.zone.at((self.to_f / seconds).round * seconds)
    end

    def floor(seconds = 60)
      Time.zone.at((self.to_f / seconds).floor * seconds)
    end   

    def shift_time_zone(new_time_zone)
      _working_date = DateTime.now.in_time_zone(new_time_zone)
      _adjusted = _working_date.change(:year => self.year, :month => self.month, :day => self.day, 
        :hour => self.hour, :min => self.min, :sec => self.sec, :usec => self.usec)    
      return _adjusted
    end           
  end
end