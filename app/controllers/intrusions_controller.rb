class IntrusionsController < ApplicationController

  def index
    @intrusions = Intrusion.all.sort
  end
  
end
