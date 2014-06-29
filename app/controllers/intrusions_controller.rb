class IntrusionsController < ApplicationController

  def index
    @intrusions = Intrusion.all.sort
  end
  
  def create
    
  end
  
  def new
    @intrusion = Intrusion.new
  end
end
