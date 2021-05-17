module TasksHelper
  def choose_new_or_edit
    if aciton_name == "new" || aciton_name == "create"
      confirm_tasks_path
    elsif aciton_name == "edit"
      tasks_path
    end
  end
 end
