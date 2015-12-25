Factory.define :message do |u|
  u.about {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
  u.body {(0..89).map{('a'..'z').to_a[rand(26)]}.join }
end

