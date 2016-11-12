class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :load_mark, only: [:edit, :update, :destroy]
  before_action :load_book

  def create
    @user_book = @book.marks.build marks_params
    @user_book.mark_type = "favorite"
    @user_book.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    if @user_book.destroy
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private
  def marks_params
    params.require(:mark).permit :user_id, :book_id, :mark_type
  end

  def load_mark
    @user_book = Mark.find_by id: params[:id]
  end

  def load_book
    @book = Book.find_by id: params[:restaurant_id]
  end
end
