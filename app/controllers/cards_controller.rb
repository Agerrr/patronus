class CardsController < ApplicationController

  def create
		virtual_card_resp_json = JSON.parse(get_virtual_card.body)

		@card = Card.create(
			account_number: virtual_card_resp_json["accountNumber"],
			message_id: virtual_card_resp_json["messageId"],
			expiration_date: virtual_card_resp_json["expirationDate"],
			security_code: get_security_code(virtual_card_resp_json),
			requisition_id: virtual_card_resp_json["requisitionId"])

		@card.save
	end

	private

	def get_security_code(virtual_card_resp_json)
		request_body = '''{"messageId": "1526417600960", "clientId": "B2BWS_1_1_9999", "buyerId": 9999, "accountNumber": 4111111111111111, "expirationDate": "01/2034"}'''
		cvv_resp = mutual_auth_req("/vpa/v1/accountManagement/GetSecurityCode", "post", request_body)

		JSON.parse(cvv_resp.body)["securityCode"]
	end

	def get_virtual_card
		request_body = '''{
"messageId": "1526417600960",
"clientId": "B2BWS_1_buyer_1940",
"buyerId": 9999,
"accountNumber": "",
"proxyPoolId": "M1",
"employee": {
"firstName": "FirstName",
"lastName": "LastName",
"employeeId": "ABCD123",
"companyAdminEMailId": "compAdmin@bbb.com",
"eMailId": "compAdmin@bbb.com",
"costCenter": "1",
"gl": "1",
"address": {
"addressLine1": "",
"addressLine2": "",
"city": "",
"state": "",
"postalCode": "",
"countryCode": "USA"
}
},
"optionalField1": "1",
"optionalField2": "2",
"optionalField3": "3",
"optionalField4": "4",
"optionalField5": "5",
"requisitionDetails": [
{
"startDate": "2018-05-15",
"endDate": "2018-05-30",
"timeZone": "UTC+08",
"rules": [
{
"ruleCode": "SPV",
"overrides": [
{
"sequence": 1,
"overrideCode": "spendLimitAmount",
"overrideValue": 10000
},
{
"sequence": 2,
"overrideCode": "maxAuth",
"overrideValue": 50
},
{
"sequence": "3",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "4",
"overrideCode": "rangeType",
"overrideValue": "3"
},
{
"sequence": "5",
"overrideCode": "startDate",
"overrideValue": "05/15/2018"
},
{
"sequence": "5",
"overrideCode": "endDate",
"overrideValue": "05/30/2018"
},
{
"sequence": "7",
"overrideCode": "updateFlag",
"overrideValue": "NOCHANGE"
}
]
},
{
"ruleCode": "PUR",
"overrides": [
{
"sequence": "0",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "0",
"overrideCode": "amountValue",
"overrideValue": "55"
}
]
},
{
"ruleCode": "EAM",
"overrides": [
{
"sequence": "0",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "0",
"overrideCode": "amountValue",
"overrideValue": "55"
}
]
},
{
"ruleCode": "XBRA",
"overrides": [
{
"sequence": "0",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "0",
"overrideCode": "amountValue",
"overrideValue": "55"
}
]
},
{
"ruleCode": "ATML",
"overrides": [
{
"sequence": "0",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "0",
"overrideCode": "amountValue",
"overrideValue": "55"
}
]
},
{
"ruleCode": "TOLRNC",
"overrides": [
{
"sequence": "0",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "0",
"overrideCode": "minValue",
"overrideValue": "1"
},
{
"sequence": "0",
"overrideCode": "maxValue",
"overrideValue": "50"
}
]
},
{
"ruleCode": "CAID",
"overrides": [
{
"sequence": "0",
"overrideCode": "CAIDValue",
"overrideValue": "55"
}
]
},
{
"ruleCode": "ATM"
},
{
"ruleCode": "ECOM"
},
{
"ruleCode": "CNP"
},
{
"ruleCode": "NOC"
},
{
"ruleCode": "ADT"
},
{
"ruleCode": "XBR"
},
{
"ruleCode": "FUEL"
},
{
"ruleCode": "HOT"
},
{
"ruleCode": "AUTO"
},
{
"ruleCode": "AIR"
},
{
"ruleCode": "REST"
},
{
"ruleCode": "JEWL"
},
{
"ruleCode": "ELEC"
},
{
"ruleCode": "ALC"
},
{
"ruleCode": "GTM"
},
{
"ruleCode": "OSS"
},
{
"ruleCode": "GROC"
},
{
"ruleCode": "ENT"
},
{
"ruleCode": "UTIL"
},
{
"ruleCode": "CLOTH"
},
{
"ruleCode": "MED"
},
{
"ruleCode": "VPAS",
"overrides": [
{
"sequence": "0",
"overrideCode": "amountCurrencyCode",
"overrideValue": "840"
},
{
"sequence": "0",
"overrideCode": "amountValue",
"overrideValue": "65"
},
{
"sequence": "1",
"overrideCode": "amountValue",
"overrideValue": "205"
}
]
},
{
"ruleCode": "DOM",
"overrides": [
{
"sequence": "0",
"overrideCode": "cardAcceptorStateOrProvinceCode",
"overrideValue": "15"
}
]
}
]
}
]
}
    '''
		mutual_auth_req("/vpa/v1/accountManagement/VirtualCardRequisition", "post", request_body)
	end

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
