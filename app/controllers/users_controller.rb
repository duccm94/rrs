class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.not_is_admin.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    if @user.nil?
      flash[:warning] = t "views.users.show.nouser"
      redirect_to root_url
    end

    @activities = @user.activities.order("created_at desc").limit(100)
      .paginate page: params[:page], per_page: Settings.per_page
    @favorite_books = Book.favorite_books(@user)
    @followings = @user.following
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controllers.flash.common.create_success",
        objects: t("activerecord.model.user")
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.flash.common.update_success",
        objects: t("activerecord.model.user")
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
