class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_request, only: [:destroy]

  def index
    @requests = current_user.requests.order("id DESC")
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t "controllers.flash.common.create_success",
        objects: t("activerecord.model.request")
      redirect_to requests_url
    else
      render :new
    end
  end

  def destroy
    if @request && @request.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.request")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.request")
    end
    redirect_to requests_url
  end

  private
  def request_params
    params.require(:request).permit :book_title, :book_author, :content
  end

  def load_request
    @request = Request.find_by id: params[:id]
  end
end
