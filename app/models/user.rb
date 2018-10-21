class User < ApplicationRecord

	has_many :contracts

	def full_name
		"#{first_name} #{last_name}"
	end
end
