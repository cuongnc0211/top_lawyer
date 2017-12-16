class Search::TopPagesController < ApplicationController
  def index
    search_content = params[:q]
    @questions = Question.search(title_or_content_cont: search_content).result(distinct: true)
      .page(params[:page]).per Settings.search.per_page.default
    @articles = Article.search(title_or_content_cont: search_content).result(distinct: true)
      .page(params[:page]).per Settings.search.per_page.default
    @lawyer_profiles =LawyerProfile.search(account_name_or_account_email_or_lawyer_id_or_address_or_phone_number_or_fax_number_or_introduction_cont: search_content)
        .result(distinct: true).page(params[:page]).per Settings.search.per_page.default
    @law_firms = LawFirm.search(name_or_phone_number_or_fax_or_email_or_address_or_introduction_cont: search_content)
      .result(distinct: true).page(params[:page]).per Settings.search.per_page.default
  end
end
