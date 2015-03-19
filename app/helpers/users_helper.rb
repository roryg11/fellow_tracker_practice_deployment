module UsersHelper
  def user_path(role = "user", user = nil, action = nil)
    send "#{format_sti(action, role, user)}_path", user
  end

  def format_sti(action, role, user)
    action || user ? "#{format_action(action)}#{role.underscore}" : "#{role.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end
end
