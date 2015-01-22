class EventsController < ApplicationController

  def index
    @events = User.find(params[:user_id]).events
  end

  def new
    @user  = User.find(params[:user_id])
    @event = @user.events.build 
  end

  def create
    user = User.find(params[:user_id])
    @event = user.events.build(events_params)
    if @event.save
      redirect_to user_path(user) 
    else
      redirect_to new_user_event_path(user)
    end
  end

  def show
  end
  

  private
  
  def events_params
    params.require(:event).permit(:title, :location, :date, :description)
  end
end
