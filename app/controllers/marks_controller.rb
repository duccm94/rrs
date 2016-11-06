class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :load_mark, only: [:edit, :update, :destroy]
  before_action :load_book

  def create
    @user_book = @book.marks.build marks_params
    if @user_book.save
      flash[:success] = t "userbook.create.success"
    end
    redirect_to restaurant_path @user_book.book
  end

  def edit
  end

  def update
    if @user_book.update_attributes marks_params
      flash[:success] = t "userbook.create.success"
    end
    redirect_to restaurant_path @book
  end

  def destroy
    if @user_book.destroy
      redirect_to restaurant_path @book
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
