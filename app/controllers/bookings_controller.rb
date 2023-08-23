class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
    @booking = Booking.where(user: current_user).find(params[:id])
  end
  
  def new
    @user = User.find(params[:id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.where(user: current_user).new(booking_params)
    @booking.save!
    redirect_to bookings_path(current_user)
  end

  def destroy
    @booking = Booking.current_user
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end
  
  private
  
  def booking_params
    params.require(:booking).permit(:date_begin, :date_end)
  end

  
end
