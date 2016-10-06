FactoryGirl.define do
  factory :property do
    customer nil
    block nil
    property_type 1
    commercial_situation 1
    release_status 1
    description "MyText"
    price 1.5
    tax 1.5
    area 1
    square_meter_price 1.5
    rooms 1
    bathrooms 1
    parking_spaces 1
    floot 1
    sun_position "MyString"
  end
end
