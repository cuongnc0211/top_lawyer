class Lawyer::OutLawFirmsController < Lawyer::BaseController
  def destroy
    LawyerProfile.find_by(account_id: current_account).update_attributes(law_firm_id: nil)
    redirect_to law_firm_path(params[:id])
  end
end
