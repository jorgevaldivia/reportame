require 'spec_helper'

describe Incident do

  before(:all)    { I18n.locale = :en}
  after(:all)     { Incident.delete_all }

  describe "validations" do
    let(:subject)         { Incident.new(city: "Tyler", latitude: 20.289249, longitude: -103.495545) }
    let(:valid_subject)   { FactoryGirl.create(:incident) }
    before(:all)          { subject.save }
    before(:all)          { valid_subject.save }
    after(:all)           { Incident.delete_all }

    describe "valid" do
      it("should allow Zapopan as a city")      { valid_subject.errors.messages[:city].should be nil }
      it("should allow within 20 miles")        { valid_subject.errors.messages[:base].should be nil }
    end

    describe "invalid" do
      it("should not allow tyler as a city")    { subject.errors.messages[:city].should include(I18n.t("activerecord.errors.messages.inclusion")) }
      it("should require description")          { subject.errors.messages[:description].should include(I18n.t("errors.messages.blank")) }
      it("should require type")                 { subject.errors.messages[:incident_type].should include(I18n.t("errors.messages.blank")) }
      it("should require occurred_at")          { subject.errors.messages[:occured_at].should include(I18n.t("errors.messages.blank")) }
      it("should not allow outside of 20mi")    { subject.errors.messages[:base].should include(I18n.t("activerecord.errors.messages.not_within_bounds")) }
    end

    it("should set state to Jalisco")           { subject.state.should eq "Jalisco" }
    it("should set country to Mexico")          { subject.country.should eq "Mexico" }
  end

  describe "statistics" do
  	before :all do
  		4.times { FactoryGirl.create(:incident, incident_type: "robbery") }
  		3.times { FactoryGirl.create(:incident, incident_type: "assault") }
  		1.times { FactoryGirl.create(:incident, incident_type: "auto_theft") }
  		2.times { FactoryGirl.create(:incident, incident_type: "other") }
  	end

  	let( :stats ) { Incident.statistics}

  	it("should set robbery to 40") 				      { stats.detect{ |x| x.id == "robbery" }.percentage.should eq 40 }
  	it("should set assault to 30") 				      { stats.detect{ |x| x.id == "assault" }.percentage.should eq 30 }
  	it("should set auto_theft to 10") 		      { stats.detect{ |x| x.id == "auto_theft" }.percentage.should eq 10 }
  	it("should set other to 20") 					      { stats.detect{ |x| x.id == "other" }.percentage.should eq 20 }
  end
end
