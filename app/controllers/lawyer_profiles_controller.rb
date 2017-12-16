class LawyerProfilesController < ApplicationController
  def show
    @lawyer_profile = LawyerProfile.find params[:id]
    @account = @lawyer_profile.account
    @law_firm_id = @lawyer_profile.law_firm
    @lawyer_article = @account.articles
    @answers = @account.answers
    @reviews = @lawyer_profile.reviews
  end
end
