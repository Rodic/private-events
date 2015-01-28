class EventsController < ApplicationController
  
  before_action :correct_user, only: [ :new, :create ]

  def index
    @past_events     = Event.past.includes(:creator)
    @upcoming_events = Event.upcoming.includes(:creator)
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
    @event = Event.find(params[:id])
  end
  

  private
  
    def events_params
      params.require(:event).permit(:title, :location, :date, :description)
    end
    
    def correct_user
      redirect_to signin_path unless session[:user_id].to_i == params[:user_id].to_i
    end
end
