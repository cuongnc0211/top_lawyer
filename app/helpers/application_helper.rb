module ApplicationHelper
  def my_page_link account
    if account.role == "Admin"
      link_to t(".my_page"),admin_root_path
    elsif account.role == "Lawyer" && account.lawyer_profile.active?
      link_to t(".my_page"), lawyer_root_path
    else
      link_to t(".my_page"),user_root_path
    end
  end
end
