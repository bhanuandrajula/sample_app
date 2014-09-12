FactoryGirl.define do
  factory :user do
	name  'facgirl1user1'
    email 'facgirl11@gmail.com'
    password 'facgirl'
    password_confirmation 'facgirl'
  end
  
  factory :micropost do
  content "Bhanu's microposts"
  user
end


end





