Factory.define :comment do |u|
  u.body 'Corpo do comentario'
  u.commentable_type "Photo"
  u.commentable_id 1
  u.approved true
end

