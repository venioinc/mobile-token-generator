class TokenGeneratorController < ApplicationController

	def index
		# iPhone
		# iPod
		# iPad
		if request.user_agent =~ /iPad|iPhone|iPod/ then
			@token = Token.create! :token => generate_identifier
			render :text => "Thank you for verifing that you're on an iPhone/iPod/iPod Touch, your token is: " + @token.token
		else
			render :text => "Please access this website using an iPhone, iPad or iPod Touch to receive a token!"
		end
	end

	def generate_identifier
	now = Time.now.to_i  
	Digest::MD5.hexdigest(
	  (request.referrer || '') + 
	  rand(now).to_s + 
	  now.to_s + 
	  (request.user_agent || '')
	)
	end

	def verify
		tokens = Token.where :token => params[:token]

		if tokens.count == 1 then
			@token = tokens.first
			render :text => "VALID", :status => :ok
		else
			render :text => "INVALID", :status => :not_found
		end
	end
end
