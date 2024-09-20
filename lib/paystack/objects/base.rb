require 'httparty'
require 'json'

class PaystackBaseObject
  include HTTParty
  base_uri 'https://api.paystack.co' # This replaces `API::BASE_URL`

  attr_reader :paystack

  def initialize(paystackObj)
    raise ArgumentError, "Paystack object cannot be nil!" if paystackObj.nil?

    @paystack = paystackObj
  end

  protected

  # Static methods

  # GET Request
  def self.initGetRequest(paystackObj, url)
    result = nil
    begin
      response = self.get(
        url,
        headers: {
          Authorization: "Bearer #{paystackObj.private_key}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      )

      raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}" unless response.success?

      result = JSON.parse(response.body)
      raise PaystackServerError.new(response), "Server Message: #{result['message']}" if result['status'] == false

    rescue JSON::ParserError => jsonerr
      raise PaystackServerError.new(response), "Invalid result data. Could not parse JSON response body\n#{jsonerr.message}"
    rescue PaystackServerError => e
      ::Utils.serverErrorHandler(e)
    end

    result
  end

  # POST Request
  def self.initPostRequest(paystackObj, url, data = {}, json = false)
    result = nil
    begin
      headers = {
        Authorization: "Bearer #{paystackObj.private_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      body = json ? data.to_json : data

      response = self.post(
        url,
        headers: headers,
        body: body
      )

      raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}" unless response.success?

      result = JSON.parse(response.body)
      raise PaystackServerError.new(response), "Server Message: #{result['message']}" if result['status'] == false

    rescue JSON::ParserError => jsonerr
      raise PaystackServerError.new(response), "Invalid result data. Could not parse JSON response body\n#{jsonerr.message}"
    rescue PaystackServerError => e
      Utils.serverErrorHandler(e)
    end

    result
  end

  # PUT Request
  def self.initPutRequest(paystackObj, url, data = {})
    result = nil
    begin
      response = self.put(
        url,
        headers: {
          Authorization: "Bearer #{paystackObj.private_key}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        },
        body: data.to_json
      )

      raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}" unless response.success?

      result = JSON.parse(response.body)
      raise PaystackServerError.new(response), "Server Message: #{result['message']}" if result['status'] == false

    rescue JSON::ParserError => jsonerr
      raise PaystackServerError.new(response), "Invalid result data. Could not parse JSON response body\n#{jsonerr.message}"
    rescue PaystackServerError => e
      Utils.serverErrorHandler(e)
    end

    result
  end

  # DELETE Request
  def self.initDeleteRequest(paystackObj, url)
    result = nil
    begin
      response = self.delete(
        url,
        headers: {
          Authorization: "Bearer #{paystackObj.private_key}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      )

      raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}" unless response.success?

      result = JSON.parse(response.body)
      raise PaystackServerError.new(response), "Server Message: #{result['message']}" if result['status'] == false

    rescue JSON::ParserError => jsonerr
      raise PaystackServerError.new(response), "Invalid result data. Could not parse JSON response body\n#{jsonerr.message}"
    rescue PaystackServerError => e
      Utils.serverErrorHandler(e)
    end

    result
  end
end

# class PaystackBaseObject
# 	require 'json'

# 	attr_reader :paystack

# 	def initialize(paystackObj)
# 		unless !paystackObj.nil?
# 			raise ArgumentError, "Paystack object cannot be nil!!"
# 		end
# 		@paystack = paystackObj
# 	end

# 	protected
# 	# =>Static methods
# 	def self.initGetRequest(paystackObj, url) 
# 		result = nil
# 		begin
# 			response = RestClient.get "#{API::BASE_URL}#{url}" , :Authorization  => "Bearer #{paystackObj.private_key}", :content_type => :json, :accept => :json
# 			unless (response.code == 200 || response.code == 201)
# 					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
# 			end
# 			result = JSON.parse(response.body)
# 			unless(result['status'] != 0 )
# 				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
# 			end

# 		rescue JSON::ParserError => jsonerr
# 			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

# 		rescue PaystackServerError => e
# 			Utils.serverErrorHandler(e)
# 		end	
# 		return result
# 	end

# 	def self.initPostRequest(paystackObj, url, data = {}, json=false ) 
# 		result = nil
#     begin
# 			if !json
# 				response =  RestClient.post "#{API::BASE_URL}#{url}" , data,  :authorization  => "Bearer #{paystackObj.private_key}"
# 			else
# 				response =  RestClient.post "#{API::BASE_URL}#{url}" , data.to_json,  :authorization  => "Bearer #{paystackObj.private_key}", :content_type => :json, :accept => :json
		
# 			end
# 			unless (response.code == 200 || response.code == 201)
# 					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
# 			end
# 			result = JSON.parse(response.body)
# 			unless(result['status'] != 0 )
# 				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
# 			end

# 		rescue JSON::ParserError => jsonerr
# 			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

# 		rescue PaystackServerError => e
# 			Utils.serverErrorHandler(e)
# 		end	
# 		return result
# 	end

# 	def self.initPutRequest(paystackObj, url, data = {} ) 
# 		result = nil
# 		begin
# 			response =  RestClient.put "#{API::BASE_URL}#{url}" , data,  :Authorization  => "Bearer #{paystackObj.private_key}"
# 			unless (response.code == 200 || response.code == 201)
# 					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
# 			end
# 			result = JSON.parse(response.body)
# 			unless(result['status'] != 0 )
# 				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
# 			end

# 		rescue JSON::ParserError => jsonerr
# 			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

# 		rescue PaystackServerError => e
# 			Utils.serverErrorHandler(e)
# 		end	
# 		return result
# 	end

# 	def self.initDeleteRequest(paystackObj, url) 
# 		result = nil
# 		begin
# 			response =  RestClient.delete "#{API::BASE_URL}#{url}" ,  :Authorization  => "Bearer #{paystackObj.private_key}"
# 			unless (response.code == 200 || response.code == 201)
# 					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
# 			end
# 			result = JSON.parse(response.body)
# 			unless(result['status'] != 0 )
# 				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
# 			end

# 		rescue JSON::ParserError => jsonerr
# 			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

# 		rescue PaystackServerError => e
# 			Utils.serverErrorHandler(e)
# 		end	
# 		return result
# 	end
# end
