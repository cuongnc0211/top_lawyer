class ClipsController < User::BaseController
  def create
    @clip = Clip.new account_id: current_account.id, article_id: params[:clip][:article_id]
    @article = @clip.article
    if @clip.save
      respond_to{|format| format.js}
    else
      flash.now[:error] = t ".failed"
    end
  end

  def destroy
    @clip = Clip.find params[:id]
    @article = @clip.article
    if @clip.destroy
      respond_to{|format| format.js}
    else
      flash.now[:error] = t ".failed"
    end
  end
end
