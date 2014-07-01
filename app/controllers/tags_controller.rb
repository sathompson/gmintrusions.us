class TagsController < ApplicationController
  
  before_filter :find_tag, only: [:show]
  
  def index
    @tags = Tag.order :name
  end
  
  def new
    @tag = Tag.new
    @form_action = :create
  end
  
  def create
    if params[:tag][:name].present?
      redirect_to Tag.create tag_params
    else
      @tag = Tag.new
      render_with_error :new, 'Name cannot be empty.'
    end
  end
  
  def show
    
  end
  
  private
  
  def render_with_error(action, error_msg)
    @error_msg = error_msg
    render action
  end
  
  def tag_params
    params.require(:tag).permit(:name)
  end
  
  def find_tag
    @tag = Tag.find(params[:id])
  end
end
