# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident do
    address_1 "MyString"
    address_2 "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    country "MyString"
    description "MyString"
    incident_type "MyString"
    occured_at "2013-09-03 22:31:41"
  end
end
