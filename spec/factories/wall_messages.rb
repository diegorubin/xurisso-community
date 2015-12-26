FactoryGirl.define do 
  factory :wall_message do
    description {(0..89).map{('a'..'z').to_a[rand(26)]}.join }
  end
end

