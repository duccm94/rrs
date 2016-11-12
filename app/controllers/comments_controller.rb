class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, :load_review, :load_comment
  before_action :correct_user, only: [:update, :destroy]

  def new
    @comment = @review.comments.build
  end

  def create
    @comment = @review.comments.build comment_params
    if @comment.save
      flash[:success] = t "controllers.flash.common.create_success",
        objects: t("activerecord.model.comment")
      redirect_to restaurant_path  @book
    else
      flash[:danger] = "Type something"
      redirect_to restaurant_path(@book)
    end
  end

  def edit
  end

  def update
    if @comment.update comment_params
      flash[:success] = t "controllers.flash.common.update_success",
        objects: t("activerecord.model.comment")
      redirect_to restaurant_path @book
    else
      flash[:danger] = t "controllers.flash.common.update_error",
        objects: t("activerecord.model.comment")
      render :edit
    end
  end

  def destroy
    if @comment && @comment.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.comment")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.comment")
    end
    redirect_to restaurant_path @book
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :content
  end

  def load_book
    @book = Book.find_by id: params[:restaurant_id]
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end
  def correct_user
    redirect_to restaurant_path(@book) if @comment.user != current_user
  end
end
