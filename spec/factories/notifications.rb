FactoryGirl.define do
  factory :notification do
    from_id 1
from_class "MyString"
to_id 1
to_class "MyString"
description "MyText"
  end

end
