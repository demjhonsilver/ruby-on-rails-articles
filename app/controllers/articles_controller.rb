class ArticlesController < ApplicationController

  
  before_action :find_article, only: [:edit, :update, :show, :delete]
  

  def index
    @articles = Article.all.order("created_at DESC")
    @articleTitles_cut = @articles.map { |article| Cutword.get(article.title, 40) }
  end
  


  def new
      @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def show
  end

  def edit
  end

  def update
      if @article.update(article_params)
      	redirect_to @article
      else
      	render 'edit'
      end
  end

  def delete
  	  @article.destroy
  	  redirect_to articles_path
  end


  private

  def find_article
     

      begin
        @article = Article.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to articles_path
      end
  end

  def article_params
       params.require(:article).permit(:title,:body)
  end


end
