FactoryGirl.define do
  factory :user do
	name  'facgirluser'
    email 'facgirl@gmail.com'
    password 'facgirl'
    password_confirmation 'facgirl'
  end
  
  factory :micropost do
  content "Bhanu's microposts"
  user
end


end





