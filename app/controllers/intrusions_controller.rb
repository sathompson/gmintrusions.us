class IntrusionsController < ApplicationController

  before_filter :find_intrusion, only: [:show, :edit, :update, :destroy]
  
  def index
    @intrusions = Intrusion.all.sort
  end
  
  def new
    @intrusion = Intrusion.new
    @form_action = 'create'
  end
  
  def create
    if params[:intrusion][:description].present?
      redirect_to Intrusion.create intrusion_params
    else
      @intrusion = Intrusion.new
      render_with_error :new, 'Description cannot be empty'
    end
  end
  
  def show
    
  end
  
  def edit
    @form_action = 'update'
  end
  
  def update
    if params[:intrusion][:description].present?
      @intrusion.update intrusion_params
      redirect_to @intrusion
    else
      render_with_error :edit, 'Description cannot be empty'
    end
  end
  
  def destroy
    @intrusion.destroy
    redirect_to :intrusions
  end
  
  def search
    if params[:q].present?
      @intrusions = Intrusion.search params[:q]
    else
      render_with_error :index, 'Search query not present'
    end
  end
  
  private
  
  def render_with_error(action, error_msg)
    @error_msg = error_msg
    render action
  end
  
  def find_intrusion
    @intrusion = Intrusion.find(params[:id])
  end
  
  def intrusion_params
    params.require(:intrusion).permit(:description)
  end
end
