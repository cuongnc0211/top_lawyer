class Lawyer::RequestLawFirmsController < Lawyer::BaseController
  def index
    @request_lfs = current_account.law_firm.request_law_firms
  end

  def destroy
    @request_lf = RequestLawFirm.find(params[:id])
    if params[:approve] == "1"
      lawyer = LawyerProfile.find_by(account_id: @request_lf.account_id)
      lawyer.update_attributes(law_firm_id: @request_lf.law_firm_id)
      request_lfs = RequestLawFirm.where(account_id: @request_lf.account_id)
      request_lfs.each do |rlf|
        rlf.destroy
      end
    end
    @request_lf.destroy
    redirect_to lawyer_request_law_firms_path
  end
end
