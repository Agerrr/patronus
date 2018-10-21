
desc "Create users for demo"
task :create_users => :environment do

  User.create(
			user_name: "blah",
			first_name: "blah",
			last_name: "blah",
			university: "blah",
			degree: "blah",
			linkedin_profile: "blah",
			languages: "blah",
			olympiads: "blah",
			courses: "blah",
			has_offer: true,
			offer_letter: "blah",
			education: "BS Pure Mathematics",
			description: "Just some guy to be honest",
			total_funds: 1000,
			is_investor: false)
end