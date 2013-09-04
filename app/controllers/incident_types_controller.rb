class IncidentTypesController < ApplicationController
  def index
  	@statistics = Incident.statistics

    respond_to do |format|
      format.html
      format.json{ render json: @statistics.to_json }
    end
  end
end
