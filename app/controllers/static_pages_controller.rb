class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @books = Book.order("created_at desc").limit(20)
      .paginate page: params[:page], per_page: Settings.per_page
    @activities = Activity.order("created_at desc").limit(100)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def help
  end

  def contact
  end
end
