class VirtualCardsController < ApplicationController

	def create
		virtual_card_resp = mutual_auth_req("/vpa/v1/accountManagement/VirtualCardRequisition", "post", request_body)
		virtual_card_resp
	end

	def cvv
	end

	private

	def getCorrelationId()
    # Passing correlation id header (ex-correlation-id) is optional while making API calls.
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    return correlation_id
  end

	def mutual_auth_req(path, method_type, request_body, headers={})
		@config = YAML.load_file('configuration.yml')

    url = "#{@config['visaUrl']}#{path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    correlation_id = getCorrelationId()

    if method_type == 'post' || method_type == 'put'
      headers['Content-type'] = 'application/json'
    end

    headers['accept'] = 'application/json'
    headers['ex-correlation-id'] = "#{correlation_id}_SC" 

    begin
      response = RestClient::Request.execute(
      :method => method_type,
      :url => url,
      :headers => headers,
      :payload => request_body,
      :user => user_id,
      :password => password,
      :ssl_client_key => OpenSSL::PKey::RSA.new(File.read(key_path)),
      :ssl_client_cert =>  OpenSSL::X509::Certificate.new(File.read(cert_path))
      )
      return response

    rescue RestClient::ExceptionWithResponse => e
      return e.response.code.to_s
    end
  end

end
