class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # ability definitions...
  end
end