FactoryGirl.define do

  factory :comment do
    body 'Corpo do comentario'
    commentable_type "Photo"
    commentable_id 1
    approved true
  end

end

