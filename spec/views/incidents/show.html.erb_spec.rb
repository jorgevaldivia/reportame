require 'spec_helper'

describe "incidents/show" do
  before(:each) do
    @incident = assign(:incident, stub_model(Incident,
      :address_1 => "Address 1",
      :address_2 => "Address 2",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :country => "Country",
      :description => "Description",
      :incident_type => "Incident Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address 1/)
    rendered.should match(/Address 2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip/)
    rendered.should match(/Country/)
    rendered.should match(/Description/)
    rendered.should match(/Incident Type/)
  end
end
