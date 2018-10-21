
desc "Create users for demo"
task :create_users => :environment do
	response = RestClient::Request.execute(:method => "get", :url => 'https://randomuser.me/api/')
	json = JSON.parse(response.body)["results"][0]
	
  User.create(
			email: json["email"],
			first_name: json["name"]["first"],
			last_name: json["name"]["last"],
			user_name: "#{json["name"]["first"]}.#{json["name"]["last"]}",
			university: "UCSB",
			degree: "BS Pure Maths",
			linkedin_profile: "blah",
			languages: "ES, EN",
			olympiads: "blah",
			courses: "blah",
			has_offer: true,
			image_url: json["picture"]["large"],
			nat: json["nat"],
			offer_letter: "blah",
			education: "BS Pure Mathematics",
			description: "Just some guy to be honest",
			total_funds: 1000,
			gender: json["gender"],
			is_investor: false)
end

