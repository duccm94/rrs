class LikeBooksController < ApplicationController
  before_action :logged_in_user, :load_book

  def create
    @like = current_user.like_books.create like_book_params
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy
    @like = LikeBook.find_by id: params[:id]
    @like.destroy if @like
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private
  def like_book_params
    params.require(:like_book).permit :book_id
  end

  def load_book
    @book = Book.find_by id: params[:like_book][:book_id]
  end
end
