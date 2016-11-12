class BooksController < ApplicationController
  before_action :logged_in_user, except: :show

  def index
    @books = Book.search(params[:search], params[:rate_score]).order("title")
      .paginate page: params[:page], per_page: Settings.per_page
    if @books.blank?
      flash[:warning] = t ".warning"
    end
  end

  def show
    @book = Book.find_by id: params[:id]
    @reviewed = @book.reviews.find_by user_id: current_user.id
    unless current_user.nil?
      @marked_book = @book.marks.find_by user_id: current_user.id
      @user_book = @book.marks.build
    end
  end
end
