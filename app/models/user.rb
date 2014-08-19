class User < ActiveRecord::Base
#attr_accessible :name, :email    # To change the values by the user in future
#validates :name, :presence =>true
#validates_presence_of(:name)
email_regex = /\A[\w+\-.]+@[a-z.\d\-.]+\.[a-z]+\z/i;

validates :name, 	:presence 	=> true,
					:length 	=>{ :maximum => 50}
		  
validates :email, 	:presence 	=> true,
					:format 	=>{ :with => email_regex},
					:uniqueness =>{ :case_sensitive => false}


end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

