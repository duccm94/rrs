class Admin::ReviewsController < ApplicationController
  before_action :logged_as_admin
  before_action :load_book, :load_review, only: [:destroy]
  after_action :calculate_score, only: :destroy
  def destroy
    if @review && @review.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.review")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.review")
    end
    redirect_to admin_restaurant_path @book
  end

  private
  def load_book
    @book = Book.find_by id: params[:restaurant_id]
  end

  def load_review
    @review = Review.find_by id: params[:id]
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
