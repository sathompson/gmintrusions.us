class IntrusionsController < ApplicationController

  def index
    @intrusions = Intrusion.all.sort
  end
  
  def create
    if params[:intrusion][:description].present?
      redirect_to Intrusion.create intrusion_params
    else
      @intrusion = Intrusion.new
      render :new, locals: { errorMsg: 'Description cannot be empty' }
    end
  end
  
  def new
    @intrusion = Intrusion.new
  end
  
  def show
    @intrusion = Intrusion.find(params[:id])
  end
  
  private
    def intrusion_params
      params.require(:intrusion).permit(:description)
    end
end
