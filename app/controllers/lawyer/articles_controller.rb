class Lawyer::ArticlesController < Lawyer::BaseController
  include Wicked::Wizard
  include SetupWizard

  before_action :article

  steps :new, :tag, :finish

  def index
    @articles = current_account.articles.publish.page(params[:page])
      .per Settings.per_page.default
  end

  def show
  end

  def new
    @article = Article.new
    @categories = Category.all
    @tags = Tag.all.where.not(name: @article.tags.pluck(:name))
    gon.tags = @article.tags.pluck(:name)
    render layout: "article"
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @tags = Tag.all.where.not(name: @article.tags.pluck(:name))
    gon.tags = @article.tags.pluck(:name)
    render layout: "article"
  end

  def create
    params[:tag_list] = params[:tag_list].downcase! if params[:tag_list]
    @categories = Category.all
    case step
    when :new
      @article = Article.new
      render :new
    when :tag
      @article = current_account.articles.new(article_params)
      if @article.save
        if @article.publish?
          ::CreateHistoryPointService.new(point: Point.article.first, account: @article.account).perform
          ::UpdatePointLawyerService.new(@article.account.lawyer_profile).perform
        end
        render_wizard
        flash[:success] = t ".new"
      else
        puts @article.errors.full_messages
        flash.now[:alert] = t ".Please_correct_the_form"
        render :new
      end
    when :finish
      article = Article.find params[:article_id]
      article.tags.pluck(:id).each do |n|
        Tag.find(n).tag_descriptions.create account_id: current_account.id,
          content: params[:tags][n.to_s][:content]
      end
      # CreateToolTipService.new(article, article.all_tags).perform
      redirect_to article_path(article)
    end
  end

  def update
    params[:tag_list] = params[:tag_list].downcase! if params[:tag_list]
    @article = Article.find(params[:id])
    case step
    when :new
    when :tag
      from_draft = true if @article.draft?
      if @article.update_attributes article_params
        if from_draft
          ::CreateHistoryPointService.new(point: Point.article.first, account: @article.account).perform
          ::UpdatePointLawyerService.new(@article.account.lawyer_profile).perform
        end
        render_wizard
        flash[:success] = t ".updated"
      else
        puts @article.errors.full_messages
        flash.now[:error] = t ".fail"
        render :edit
      end
    when :finish
      article = Article.find params[:article_id]
      article.all_tags.each do |tag|
        create_or_update_tag_des tag, current_account.id, params
      end
      # CreateToolTipService.new(article, article.all_tags).perform
      redirect_to lawyer_articles_path
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def create_or_update_tag_des tag, account_id, params
    if td = tag.tag_descriptions.find_by(account_id: account_id)
      td.update_attributes content: params[:tags][n.to_s][:content]
    else
      tag.tag_descriptions.create account_id: current_account.id,
        content: params[:tags][n.to_s][:content]
    end
  end

  def article_params
    params.require(:article).permit Article::ARTICLE_ATTRIBUTES
  end

  def article
    return if params[:id].nil?
    article = Article.find params[:id]
    unless (current_account.Admin? || current_account == article.account)
      flash[:error] = t ".access_denies"
      redirect_to root_path
    end
  end
end
