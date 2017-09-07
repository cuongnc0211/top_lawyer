class LawFirmsController < ApplicationController
  def show
    @law_firm = LawFirm.find params[:id]
  end
end
