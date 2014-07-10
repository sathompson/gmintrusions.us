class TagsController < ApplicationController
  before_filter :find_tag, only: [:show, :edit, :update, :destroy]
  
  ERR_EMPTY_NAME = 'Name cannot be empty.'
  ERR_UNKNOWN = 'Something went wrong.'
  
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
      render_with_error :new, ERR_EMPTY_NAME
    end
  end
  
  def show
    @intrusions = @tag.intrusions.sort
  end
  
  def edit
    @form_action = :update
  end
  
  def update
    if params[:tag][:name].present?
      if @tag.update tag_params
        redirect_to @tag
      else
        render_with_error :edit, ERR_UNKNOWN
      end
    else
      render_with_error :edit, ERR_EMPTY_NAME
    end
  end
  
  def destroy
    @tag.destroy
    redirect_to :tags
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
