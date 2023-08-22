class CastlesController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @castles = Castle.all
  end

  def show
    @castle = Castle.find(params[:id])
  end

  def new
    @castle = Castle.new
  end

  def create
    @castle = Castle.new(castle_params)
    @castle.user = current_user

    if @castle.save
      redirect_to castle_path(@castle)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @castle = Castle.find(params[:id])
    @castle.destroy
    redirect_to castles_path
  end

  def mine
  end

  private

  def castle_params
    params.require(:castle).permit(:name, :address, :description, :price, photos: [])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
