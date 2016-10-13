FactoryGirl.define do
  factory :product do
    name "MyString"
    description "MyText"
    market nil
    photo "MyString"
    image_secure_token "MyString"
    price 1.5
    status false
  end
end
