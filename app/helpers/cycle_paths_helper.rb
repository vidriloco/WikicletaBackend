module CyclePathsHelper
  def user_can_edit_cycle_path?(user, cycle_path)
    return false if user.nil?
    cycle_path.users.include?(user) || user.can_contribute_to_city?
  end
end
