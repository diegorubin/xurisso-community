FactoryGirl.define do

  factory :album do
    title 'album de teste'
    description 'um simples album'

    user {create(:confirmed_user)}

  end

end

