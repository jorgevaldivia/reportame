require 'spec_helper'

describe Incident do
  describe "statistics" do
  	before :all do
  		4.times { FactoryGirl.create(:incident, incident_type: "robbery") }
  		3.times { FactoryGirl.create(:incident, incident_type: "assault") }
  		1.times { FactoryGirl.create(:incident, incident_type: "auto_theft") }
  		2.times { FactoryGirl.create(:incident, incident_type: "other") }
  	end
  	after(:all){ Incident.delete_all }

  	let( :stats ) { Incident.statistics}

  	it("should set robbery to 40") 				{ stats.detect{ |x| x.name == "robbery" }.percentage.should eq 40 }
  	it("should set assault to 30") 				{ stats.detect{ |x| x.name == "assault" }.percentage.should eq 30 }
  	it("should set auto_theft to 10") 		{ stats.detect{ |x| x.name == "auto_theft" }.percentage.should eq 10 }
  	it("should set other to 20") 					{ stats.detect{ |x| x.name == "other" }.percentage.should eq 20 }
  end
end
