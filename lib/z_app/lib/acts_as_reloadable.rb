module ActsAsReloadable
  def self.included(base)
    ActiveSupport::Dependencies.explicitly_unloadable_constants << base.name if ['development', 'test'].include?(Rails.env)
  end
end

class Object
  def self.acts_as_reloadable
    ActiveSupport::Dependencies.explicitly_unloadable_constants << self.name if ['development', 'test'].include?(Rails.env)
  end
end