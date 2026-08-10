# frozen_string_literal: true
class CommentsController < InertiaController
  before_action :require_login

  def create
    article = Article.find(params[:article_id])
    comment = article.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_back fallback_location: article_path(article)
    else
      redirect_back fallback_location: article_path(article), inertia: { errors: comment.errors }
    end
  end

  def destroy
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:id])

    unless comment.user == current_user || article.user == current_user
      return redirect_back fallback_location: article_path(article), inertia: { errors: { base: "No autorizado" } }
    end

    comment.destroy
    redirect_back fallback_location: article_path(article)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end