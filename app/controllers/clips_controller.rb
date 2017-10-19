class ClipsController < User::BaseController
  def create
    @clip = Clip.new account_id: current_account.id, article_id: params[:clip][:article_id]
    @clip.save
    redirect_to article_path(@clip.article)
  end

  def destroy
    @clip = Clip.find params[:id]
    article = @clip.article
    @clip.destroy
    redirect_to article_path(article)
  end
end
