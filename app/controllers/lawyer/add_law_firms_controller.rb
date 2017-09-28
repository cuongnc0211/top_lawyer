class Lawyer::AddLawFirmsController < Lawyer::BaseController
  def index
    @add_lfs = LawyerProfile.find_by(account_id: current_account).add_law_firms
  end
  def create
    add_lf = LawyerProfile.find_by(id: params[:add_id]).add_law_firms.new
    add_lf.law_firm_id = LawyerProfile.find_by(account_id: current_account).law_firm_id
    if add_lf.save
      redirect_to lawyer_law_firm_members_path(current_account)
      flash[:success] = t ".add_success"
    else
      flash.now[:alert] = t ".add_error"
    end
  end

  def destroy
    @add_lf = AddLawFirm.find(params[:id])
    if params[:approve] == "1"
      LawyerProfile.find_by(account_id: current_account).update_attributes(law_firm_id: @add_lf.law_firm_id)

      add_lfs = AddLawFirm.where(lawyer_profile_id: LawyerProfile.find_by(account_id: current_account).id)
      add_lfs.each do |alf|
        alf.destroy
      end
    end
    @add_lf.destroy
    redirect_to lawyer_add_law_firms_path
  end
end
