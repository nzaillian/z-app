class ActiveRecord::Base
  # an "unsafe" save method (alias for "record.save(:validate => false)")
  def u_save
    save(:validate => false)
  end
end