class AccountsController < ApplicationController
  def show
    @account = Account.find params[:id]
    @questions = @account.questions
  end
end
