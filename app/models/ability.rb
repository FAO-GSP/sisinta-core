# CanCanCan permission definitions
class Ability
  include CanCan::Ability

  def initialize(user = nil)
    @user = user || User.new

    # Load corresponding set of rules
    self.send @user.role
  end

  # Role permission
  private

  def admin
    # Can do anything
    can :manage, :all
  end

  def authorized
    # Can manage itself
    can :manage, User, id: @user.id

    # Can read every Profile and create them
    can :read, Profile
    can :create, Profile

    # Can manage it's created Profiles
    can :manage, Profile, user_id: @user.id
  end

  # Registered user
  def registered
    guest
  end

  # Guest (unregistered) user
  def guest
    can :read, Profile, public: true
  end
end
