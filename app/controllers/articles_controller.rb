# frozen_string_literal: true
class ArticlesController < InertiaController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy, :toggle_like]

    def index
      articles = Article.includes(:user, :comments, images_attachments: :blob)
      liked_article_ids = current_user ? current_user.likes.pluck(:article_id) : []

      render inertia: 'article/NewAr', props: {
        articles: articles.as_json(
          include: { user: { only: [:id, :name] } },
          methods: [:comments_count, :likes_count, :image_urls]   # 👈 plural
        ).map { |a| a.merge("liked_by_current_user" => liked_article_ids.include?(a["id"])) },
        articlesCount: Article.count
      }
    end
   def show
      article = Article.includes(:user, comments: :user, likes: :user, images_attachments: :blob).find(params[:id])
      liked = current_user ? current_user.likes.exists?(article_id: article.id) : false

      render inertia: 'article/NewAS', props: {
        article: article.as_json(
          include: {
            user: { only: [:id, :name] },
            comments: { include: { user: { only: [:id, :name] } } },
            likes: { include: { user: { only: [:id, :name] } } }
          },
          methods: [:comments_count, :likes_count, :image_urls]
        ).merge("liked_by_current_user" => liked)
      }
    end

  def new
    render inertia: 'newArticle/NewNA'
  end

  def create
    article = current_user.articles.build(article_params)
    if article.save
      redirect_to root_path
    else
      redirect_to new_article_path, inertia: { errors: article.errors }
    end
  end

  def edit
    article = Article.find(params[:id])
    return render_forbidden unless article.owned_by?(current_user)

    render inertia: 'editArticle/NewEA', props: {
      article: article.as_json(only: [:id, :title, :body])
    }
  end

  def update
    article = Article.find(params[:id])
    return render_forbidden unless article.owned_by?(current_user)

    if article.update(article_params)
      redirect_to profile_path
    else
      redirect_to edit_article_path(article), inertia: { errors: article.errors }
    end
  end

  def destroy
    article = Article.find(params[:id])
    return render_forbidden unless article.owned_by?(current_user)

    article.destroy
    redirect_back fallback_location: root_path
  end

  # app/controllers/articles_controller.rb
  def toggle_like
    article = Article.find(params[:id])
    like = current_user.likes.find_by(article: article)

    if like
      like.destroy
    else
      current_user.likes.create(article: article)
    end

    redirect_back fallback_location: articles_path
  end

  

  private

  def article_params
  params.permit(:title, :body, images: [])
end

  def render_forbidden
    redirect_to root_path, alert: "No autorizado"
  end
end