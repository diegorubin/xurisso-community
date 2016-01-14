FactoryGirl.define do

  factory :message do
    about {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    body {(0..89).map{('a'..'z').to_a[rand(26)]}.join }
    to {create(:user)}
    from {create(:user)}
  end

end

