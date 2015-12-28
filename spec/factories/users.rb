FactoryGirl.define do

  factory :user do
    login {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    email {(0..5).map{('a'..'z').to_a[rand(26)]}.join+"@example.com" }
    name {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    password "queroentrar"
    blocked false

    factory :admin do
      admin true
    end

    factory :confirmed_user do
      confirmed_at {Time.now}
    end

  end

end

