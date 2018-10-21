class ContractsController < ApplicationController
	def create
		
		url_string = '?university=Imperial+College%2C+London&degree=Master+of+Science+%28MS%29%2C+Mathematics'

		response = RestClient::Request.execute(
			:method => "GET",
			:url => 'http://localhost:5000/predict_salary'+url_string,
			:headers => {accept: "application/json"})

		print(response.body)
		
		JSON.parse(response.body)["predicted_salary"]
	end
end
