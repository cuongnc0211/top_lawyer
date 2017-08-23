class User::ArticlesController < User::BaseController

def index
end

def new
  @article = Article.new
  @category = Category.all
end

def create

end

def delete
end

private
  def article_params
    params.require(:article).permit Article::ARTICLE_ATTRIBUTES
  end
end
