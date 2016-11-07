class Admin::ReviewsController < ApplicationController
  before_action :logged_as_admin
  before_action :load_book, :load_review, only: [:destroy]
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
end
