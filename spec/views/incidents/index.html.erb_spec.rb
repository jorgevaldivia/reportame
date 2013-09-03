require 'spec_helper'

describe "incidents/index" do
  before(:each) do
    assign(:incidents, [
      stub_model(Incident,
        :address_1 => "Address 1",
        :address_2 => "Address 2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :country => "Country",
        :description => "Description",
        :incident_type => "Incident Type"
      ),
      stub_model(Incident,
        :address_1 => "Address 1",
        :address_2 => "Address 2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :country => "Country",
        :description => "Description",
        :incident_type => "Incident Type"
      )
    ])
  end

  it "renders a list of incidents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address 1".to_s, :count => 2
    assert_select "tr>td", :text => "Address 2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Incident Type".to_s, :count => 2
  end
end
