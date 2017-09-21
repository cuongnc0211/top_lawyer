class LawFirmsController < ApplicationController
  def show
    @law_firm = LawFirm.find params[:id]
    @request_lf = @law_firm.request_law_firms.find_by(account_id: current_account.id) || current_account.request_law_firms.new
  end
end
