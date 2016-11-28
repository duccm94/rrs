class BooksController < ApplicationController

  def index
    @books = Book.search(params[:search], params[:rate_score]).order("title")
      .paginate page: params[:page], per_page: Settings.per_page
    if @books.blank?
      flash[:warning] = t ".warning"
    end
  end

  def show
    @book = Book.find_by id: params[:id]
    @reviews = @book.reviews.order_by_time.paginate page: params[:page], per_page: 5
    unless current_user.nil?
      @reviewed = @book.reviews.find_by user_id: current_user.id
      @marked_book = @book.marks.find_by user_id: current_user.id
      @user_book = @book.marks.build
    end
  end
end
