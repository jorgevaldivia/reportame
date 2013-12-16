class ImagesController < ApplicationController
  before_action :set_incident

  def index
    respond_to do |format|
      format.html
      format.json{ 
        @images = @incident.images

        render json: @images.as_json
      }
     end
  end

  def show
  end

  def create
    @image = Image.new(image_params)
    @image.item_type = "Incident"
    @image.item_id = @incident.id

    respond_to do |format|
      if @image.save
        format.html { redirect_to @incident }
        format.json { render action: 'show', status: :created, location: @image }
      else
        format.html { render action: 'new' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.includes(:images).find(params[:incident_id])
    end

    def image_params
      params.require(:image).permit(:file, :file_cache, :description)
    end
end
