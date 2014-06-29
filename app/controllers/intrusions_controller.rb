class IntrusionsController < ApplicationController

  def index
    @intrusions = Intrusion.all.sort
  end
  
  def create
    if params[:intrusion][:description].present?
      redirect_to Intrusion.create intrusion_params
    else
      new_intrusion
      render :new, locals: { errorMsg: 'Description cannot be empty' }
    end
  end
  
  def new
    new_intrusion
  end
  
  def show
    @intrusion = Intrusion.find(params[:id])
  end
  
  private
  
  def new_intrusion
    @intrusion = Intrusion.new  
  end
  
  def intrusion_params
    params.require(:intrusion).permit(:description)
  end
end
