module UsersHelper
  def admin?
    if logged_in?
      current_user.admin == "admin"
    end
  end
end
