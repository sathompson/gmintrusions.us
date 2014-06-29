class IntrusionsController < ApplicationController

  def index
    @intrusions = Intrusion.all.sort
  end
  
  def create
    @intrusion = Intrusion.create intrusion_params
    
    redirect_to @intrusion
  end
  
  def new
    @intrusion = Intrusion.new
  end
  
  private
    def intrusion_params
      params.require(:intrusion).permit(:description)
    end
end
