class ReviewsController < ApplicationController
  before_action :logged_in_user, except: :show
  before_action :load_book
  before_action :load_review, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]
  before_action :find_review, only: :create
  after_action :calculate_score, only: :destroy

  def show
    @comments = @review.comments.order_by_time.paginate page: params[:page], per_page: 5
  end

  def new
    @review = @book.reviews.build
  end

  def create
    @review = @book.reviews.build review_params
    if @review.save
      flash[:success] = t "controllers.flash.common.create_success",
        objects: t("activerecord.model.review")
      redirect_to restaurant_path @book
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update review_params
      flash[:success] = t"controllers.flash.common.update_success",
        objects: t("activerecord.model.review")
      redirect_to restaurant_path @book
    else
      flash[:danger] = t "controllers.flash.common.update_error",
        objects: t("activerecord.model.review")
      render :edit
    end
  end

  def destroy
    if @review && @review.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.review")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.review")
    end
    redirect_to restaurant_path @book
  end

  private
  def review_params
    params.require(:review).permit :user_id, :rating, :title, :content, :image, :rating_place,
      :rating_service, :rating_food, :rating_price
  end

  def load_book
    @book = Book.find_by id: params[:restaurant_id]
  end

  def load_review
    @review = Review.find_by id: params[:id]
  end

  def correct_user
    redirect_to restaurant_path(@book) if @review.user != current_user
  end

  def find_review
    @reviewed = @book.reviews.find_by user_id: current_user.id
    if @reviewed
      flash[:danger] = "You are reviewed this restaurant"
      redirect_to restaurant_path(@book)
    end
  end

  def calculate_score
    sum_rating = 0
    sum_rating_place = 0
    sum_rating_service = 0
    sum_rating_food = 0
    sum_rating_price = 0
    count = @book.reviews.count
    @book.reviews.reduce(0)  do |sum, element|
      sum_rating = sum_rating + element.rating
      sum_rating_place = sum_rating_place + element.rating_place
      sum_rating_service = sum_rating_service + element.rating_service
      sum_rating_food = sum_rating_food + element.rating_food
      sum_rating_price = sum_rating_price + element.rating_price
    end
    if count == 0
      @book.update_attributes rate_score: 0,
        rate_place: 0, rate_service: 0,
        rate_food: 0, rate_price: 0
    else
      @book.update_attributes rate_score: sum_rating/count,
        rate_place: sum_rating_place/count, rate_service: sum_rating_service/count,
        rate_food: sum_rating_food/count, rate_price: sum_rating_price/count
    end
  end
end
