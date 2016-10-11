FactoryGirl.define do
  factory :market do
    customer nil
    segment nil
    price_category 1
    always_open false
    delivery false
    only_delivery false
    estimated_time 1
    estimated_time_suffix "MyString"
  end
end
