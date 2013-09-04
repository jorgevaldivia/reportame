# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident do
    address_1       "Avenida La Paz 2055"
    address_2       ""
    city            "Guadalajara"
    state           "Jalisco"
    zip             "44140"
    country         "Mexico"
    description     "Me robaron el estacionamiento"
    incident_type   "robbery"
    occured_at      "2013-09-03 22:31:41"
  end
end
