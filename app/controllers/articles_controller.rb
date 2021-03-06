class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  before_filter :authenticate, :excerpt =>[:index, :show, :notify_friend]

  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  def filter

  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end
  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = current_user.articles.find(params[:id])


    respond_to do |format|
      if @article.update_attributes(article_params)
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def notify_friend
    @article = Article.find(params[:id])
    Notifier.email_friend(@article, params[:name], params[:email]).deliver
    redirect_to @article, :notice => "Message envoyé avec succès"
  end

  def tagged
    if params[:tag].present? 
      @article = Article.tagged_with(params[:tag])
    else 

    end  
  end

  def search
    if params[:category_id].present?
      article = Article.all
      @article = article.joins(:categories).where("categories.id = ?",params[:category_id])
        
    else
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :location, :tag_list, :excerpt, :body , :published_at, :category_ids => [])
    end
end
