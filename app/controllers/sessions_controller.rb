require 'json'
#request should be inside a method
class SessionsController < ApplicationController
	
	def create
		auth_hash = request.env["omniauth.auth"]
=begin
		#@auth = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
		if @auth
			render :text => "Welcome back #{@auth.user.name}! You have already sign up."
		else
			user = User.new :name => auth_hash["user_info"], :email => auth_hash["user_info"]["email"]
			#build is used to persist object that does not have a primery key jet
			user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]

			user.save

			render :text => "Hi #{user.name}! You've sign up."
		end
=end
		user = User.where(provider: auth_hash['provider'], uid:  auth_hash['uid']).first || User.create_with_omniauth(auth_hash)
    	
    	session[:user_id] = user.id
    	render :text => "Signed in! #{user.name}"
    	#render :text => user.inspect


		# prints all information in screen as text. Inspects object for debugging
		Rails.logger.debug("auth #{auth_hash['info']['location'].inspect}") 
		#render :text => auth_hash.inspect
	end
end
