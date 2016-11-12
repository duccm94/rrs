class Admin::BooksController < ApplicationController
  before_action :logged_as_admin, only: [:index, :new, :create]
  before_action :get_categories, except: [:index]

  def index
    @books = Book.search(params[:search], params[:rate_score]).order("title")
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by id: params[:id]
    @marked_book = @book.marks.find_by user_id: current_user.id
    @user_book = @book.marks.build
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "controllers.flash.common.create_success",
        objects: t("activerecord.model.book")
      redirect_to admin_restaurants_url
    else
      render :new
    end
  end

  def edit
    @book = Book.find_by id: params[:id]
  end

  def update
    @book = Book.find_by id: params[:id]
    if @book.update_attributes book_params
      flash[:success] = "Resturant update success"
      redirect_to admin_restaurants_url
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find_by id: params[:id]
    if @book && @book.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.book")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.book")
    end
    redirect_to admin_restaurants_url
  end

  private
  def book_params
    params.require(:book).permit :category_id, :title, :author,
      :number_of_pages, :publish_date, :image
  end

  def get_categories
    @categories = Category.all
  end
end
