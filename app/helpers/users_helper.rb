module UsersHelper
  def admin?
    def logged_in?
      current_user.admin? == "admin"
    end
  end
end
