require 'spec_helper'

describe Incident do
  describe "statistics" do
  	before :all do
  		4.times { Factory.create(:incident, incident_type: "robbery") }
  		3.times { Factory.create(:incident, incident_type: "assault") }
  		1.times { Factory.create(:incident, incident_type: "auto_theft") }
  		2.times { Factory.create(:incident, incident_type: "other") }

  		puts Incident.pluck :incident_type
  	end

  	it("should be awesome") { true.should be true }
  end
end
