class TagsController < ApplicationController
  before_filter :find_tag, only: [:show, :edit, :update, :destroy]
  before_filter :new_tag, only: [:new, :create]
  
  def index
    @tags = Tag.order :name
  end
  
  def new
    @form_action = :create
  end
  
  def create
    create_or_update :create
  end
  
  def show
    @intrusions = @tag.intrusions.sort
  end
  
  def edit
    @form_action = :update
  end
  
  def update
    create_or_update :update
  end
  
  def destroy
    @tag.destroy
    redirect_to :tags
  end
  
  private
  
  def create_or_update(method)
    @tag.update(tag_params)
    if @tag.valid?
      redirect_to @tag
    else
      @form_action = method
      render_with_error ({create: :new, update: :edit}[method]), @tag
    end
  end
  
  def render_with_error(action, tag)
    @error_msg = tag.errors.map { |_,m| m }
    render action
  end
  
  def tag_params
    params.require(:tag).permit(:name)
  end
  
  def find_tag
    @tag = Tag.find(params[:id])
  end
  
  def new_tag
    @tag = Tag.new
  end
end
