FactoryGirl.define do

  factory :photo do
    title 'teste teste'
    description 'uma descricao'

    user {create(:confirmed_user)}

    album

  end

end

