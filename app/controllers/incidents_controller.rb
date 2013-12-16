class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  # layout "mobile.html.erb"

  # GET /incidents
  # GET /incidents.json
  def index
    respond_to do |format|
      format.html
      format.json{ 
        @incidents = Incident.order("id desc")

        # We want to show many more if map
        per_page = params[:map].present? ? 500 : 25

        @incidents = @incidents.search(params[:q])    if params[:q].present?
        @incidents = @incidents.where(incident_type: 
                      params[:incident_type])         if params[:incident_type].present?
        @incidents = @incidents.paginate(page: params[:page], per_page: per_page)

        render json: {records: @incidents.as_json(methods: [:full_address, :translated_type]), 
          types: Incident::TYPES.map{ |x| {value: x, name: Incident.translate_type(x)} },
          total_pages: @incidents.total_pages, total_entries: @incidents.total_entries, 
          offset: @incidents.offset, per_page: @incidents.per_page} 
      }
    end
  end

  def blank
    
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to root_url, notice: 'Incident was successfully created.' }
        format.json { render action: 'show', status: :created, location: @incident }
      else
        format.html { render action: 'new' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.includes(:images).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:address_1, :address_2, :city, :state, :zip, 
        :country, :description, :incident_type, :occured_at, :neighborhood, :latitude, :longitude)
    end
end
