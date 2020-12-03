class ListingsController < ApplicationController
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

    def show
      @listing = Listing.find(params[:id])
    end

  private

  def listing_params
    params.require(:listing).permit(:product, :explanation, :category_id, :status_id, :delivery_id, :area_id, :days_id, :price, :image).merge(user_id: current_user.id)
  end


  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
