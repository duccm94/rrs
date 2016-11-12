class StaticPagesController < ApplicationController

  def home
    @books = Book.order("created_at desc")
      .paginate page: params[:page], per_page: Settings.per_page_index
    @random_book = Book.random.limit 3
  end

  def help
  end

  def contact
  end
end
