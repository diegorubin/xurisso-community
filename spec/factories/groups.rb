FactoryGirl.define do
  factory :group do
    title "MyString"
    description "MyText"
    only_by_invite false
    owner_id 1
    is_private false
    cover "MyString"
  end

end
