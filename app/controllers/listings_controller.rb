class ListingsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
    if @listing.user == current_user
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    if @listing.update(listing_params)
      redirect_to listing_path(@listing.id)
    else
      render :edit
    end
  end

  def destroy
    if @listing.destroy = current_user
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:product, :explanation, :category_id, :status_id, :delivery_id, :area_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
