class CastlesController < ApplicationController
  before_action :set_user, only: %i[index new create update destroy]

  def index
    @castles = Castle.geocoded

    if params[:query].present?
      @castles = @castles.search(params[:query])
    end

    if user_signed_in?
      if current_user.castles.count.positive?
        @castles = @castles.reject { |castle| current_user.castles.include?(castle) }
      end
    end
    @markers = @castles.map do |castle|
      {
        lat: castle.latitude,
        lng: castle.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { castle: castle }),
        marker_html: render_to_string(partial: "marker", locals: { castle: castle })
      }
    end
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

  def edit
    @castle = Castle.find(params[:id])
  end

  def update
    @castle = Castle.find(params[:id])
    @castle.update(castle_params)

    redirect_to castle_path(@castle)
  end

  def destroy
    @castle = Castle.find(params[:id])
    @castle.destroy
    redirect_to castles_path, status: :see_other
  end

  def mine
  end

  private

  def castle_params
    params.require(:castle).permit(:name, :address, :description, :price, photos: [])
  end

  def set_user
    @user = current_user
  end
end
