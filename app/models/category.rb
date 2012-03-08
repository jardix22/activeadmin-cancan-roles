class Category < ActiveRecord::Base
	has_many :notices
end
