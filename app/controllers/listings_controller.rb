class ListingsController < ApplicationController
  before_action :configuer_permitted_parameters, if: :devise_controller?
  before_action :move_to_index, except: [:index, :show]

  def index
    @listing = Listing.order('created_at DESC')
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.valid?
      @listing.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:product, :explanation, :category_id, :status_id, :delivery_id, :area_id, :days_id, :price, :image).merge(user_id: current_user.id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
