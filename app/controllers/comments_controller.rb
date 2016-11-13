class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, :load_review, :load_comment
  before_action :correct_user, only: [:update, :destroy]

  def new
    @comment = @review.comments.build
  end

  def create
    @comment = @review.comments.build comment_params
    @comments = @review.comments.order_by_time
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update comment_params
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @comments = @review.comments.order_by_time
    if @comment && @comment.destroy
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
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
