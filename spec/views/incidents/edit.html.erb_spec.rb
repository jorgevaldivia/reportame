require 'spec_helper'

describe "incidents/edit" do
  before(:each) do
    @incident = assign(:incident, stub_model(Incident,
      :address_1 => "MyString",
      :address_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :country => "MyString",
      :description => "MyString",
      :incident_type => "MyString"
    ))
  end

  it "renders the edit incident form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => incidents_path(@incident), :method => "post" do
      assert_select "input#incident_address_1", :name => "incident[address_1]"
      assert_select "input#incident_address_2", :name => "incident[address_2]"
      assert_select "input#incident_city", :name => "incident[city]"
      assert_select "input#incident_state", :name => "incident[state]"
      assert_select "input#incident_zip", :name => "incident[zip]"
      assert_select "input#incident_country", :name => "incident[country]"
      assert_select "input#incident_description", :name => "incident[description]"
      assert_select "input#incident_incident_type", :name => "incident[incident_type]"
    end
  end
end
