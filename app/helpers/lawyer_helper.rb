module LawyerHelper
  def law_firm_link lawyer_profile
    if lawyer_profile.law_firm.nil? || lawyer_profile.is_manager
      link_to t(".law_firm"), new_lawyer_law_firm_path
    else
      link_to t(".law_firm"), law_firm_path(lawyer_profile.law_firm)
    end
  end
end
