class Admin::CommentsController < ApplicationController
  before_action :logged_as_admin, :load_book, :load_review, :load_comment
  def destroy
    if @comment && @comment.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.comment")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.comment")
    end
    redirect_to admin_restaurant_path @book
  end

  private
  def load_book
    @book = Book.find_by id: params[:restaurant_id]
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end
end
