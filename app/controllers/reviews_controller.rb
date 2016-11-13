class ReviewsController < ApplicationController
  before_action :logged_in_user, :load_book
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]
  before_action :find_review, only: :create
  after_action :calculate_score, only: :destroy

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
    params.require(:review).permit :user_id, :rating, :content, :image
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
    sum = @book.reviews.reduce(0) {|sum, element| sum + element.rating}
    if @book.reviews.count == 0
      average_score = 0
    else
      average_score = sum / @book.reviews.count
    end
    @book.update_attribute :rate_score, average_score
  end
end
