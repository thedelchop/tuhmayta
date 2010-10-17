class PomodoroController < ApplicationController
  def create
    @pomodoro = Pomodoro.create(params[:pomodoro])
  end

  def index
    # This is a listing of all the pomodoros for a certain day, it should take 
    # the user's current list 
    
    @pomdoros = current_user.current_list.pomdoros.count
    render :json => @pomodoros
  end

end
