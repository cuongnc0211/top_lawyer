module ApplicationHelper
  def my_page_link account
    case account.role
    when "Lawyer"
      link_to t(".my_page"), lawyer_root_path
    when "User"
      link_to t(".my_page"),user_root_path
    when "Admin"
      link_to t(".my_page"),admin_root_path
    end
  end
end
