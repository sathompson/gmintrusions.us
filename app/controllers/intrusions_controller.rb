class IntrusionsController < ApplicationController

  before_filter :find_intrusion, only: [:show, :edit, :update, :destroy]
  before_filter :new_intrusion, only: [:new, :create]
  before_filter :find_intrusion_tags, only: [:new, :edit]

  def index
    @intrusions = Intrusion.order created_at: :desc
  end

  def new
    @form_action = :create
    respond_to do |format|
      format.html
      format.json {
        render json: {
          html: render_to_string(partial: 'intrusion_form', formats: [:html]) }
      }
    end
  end

  def create
    create_or_update :create
  end

  def show

  end

  def edit
    @form_action = :update
  end

  def update
    create_or_update :update
  end

  def destroy
    @intrusion.destroy
    redirect_to :intrusions
  end

  def search
    if params[:q].present?
      @intrusions = Intrusion.search params[:q]
    else
      render_with_errors :index, ['Search query not present']
    end
  end

  private

  def create_or_update(method)
    @intrusion.update(intrusion_params)
    if @intrusion.valid?
      respond_to do |format|
        format.html {
          redirect_to @intrusion
        }
        format.json {
          render json: {
            intrusion: @intrusion,
            html: render_to_string(partial: 'intrusion', formats: [:html])
          }
        }
      end
    else
      respond_to do |format|
        format.html {
          find_intrusion_tags
          @form_action = method
          render_with_errors ({create: :new, update: :edit}[method]),
            get_errors(@intrusion)
        }
        format.json {
          render json: {
            errors: get_errors(@intrusion)
          }
        }
      end
    end
  end

  def get_errors(intrusion)
    intrusion.errors.map { |_,m| m }
  end

  def render_with_errors(action, msgs)
    @error_msgs = msgs
    render action
  end

  def intrusion_params
    params.require(:intrusion).permit(:description, tag_ids: [])
  end

  def find_intrusion
    @intrusion = Intrusion.find(params[:id])
  end

  def new_intrusion
    @intrusion = Intrusion.new
  end

  def find_intrusion_tags
    @tags = Tag.all.sort do |a,b|
      a_has_intrusion = a.intrusions.include?(@intrusion)
      !( a_has_intrusion ^ b.intrusions.include?(@intrusion) ) ?
        a.name <=> b.name : (a_has_intrusion ? -1 : 1)
    end
  end

end
