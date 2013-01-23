class SilentSanitizer < ActiveModel::MassAssignmentSecurity::Sanitizer
  
  def initialize(target)
    @target = target
    super
  end

  def process_removed_attributes(attrs)
    # do nothing (swallow)
  end
end