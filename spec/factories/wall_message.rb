Factory.define :wall_message do |u|
  u.description {(0..89).map{('a'..'z').to_a[rand(26)]}.join }
end

