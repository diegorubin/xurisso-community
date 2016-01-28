FactoryGirl.define do

  factory :photo do
    title 'teste teste'
    description 'uma descricao'

    user {create(:confirmed_user)}
    image File.open(Rails.root.join("spec/support/fixtures/image.png"))

    album

  end

end

