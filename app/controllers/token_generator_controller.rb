class TokenGeneratorController < ApplicationController

	def index
		# iPhone
		# iPod
		# iPad
		if request.user_agent =~ /iPad|iPhone|iPod/ then
			@token = Token.create! :token => generate_identifier
			render :text => @token.token
		else
			render :text => "NO"
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

end
