class BookingsController < ApplicationController
  def index
    @bookings = Booking.joins(:castle).where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @castle = Castle.find(params[:castle_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.where(user: current_user).new(booking_params)
    @booking.castle = Castle.find(params[:castle_id])
    if @booking.save
      redirect_to bookings_path()
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:date_begin, :date_end)
  end

end
