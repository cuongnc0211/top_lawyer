class RequestLawFirmsController < ApplicationController

  def new
  end

  def create
    @request_lf = current_account.request_law_firms.new
    @request_lf.law_firm_id = params[:law_firm_id]
    if @request_lf.save
      redirect_to law_firm_path(params[:law_firm_id])
      flash[:success] = t ".request"
    else
      flash.now[:alert] = t ".comment_error"
    end
  end
end
