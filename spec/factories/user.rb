Factory.define :user do |u|
  u.login {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
  u.email {(0..5).map{('a'..'z').to_a[rand(26)]}.join+"@example.com" }
  u.name {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
  u.password "queroentrar"
  u.blocked false
end
