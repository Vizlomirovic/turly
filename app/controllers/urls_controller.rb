require 'uri'

class UrlsController < ApplicationController
	def index
		@url = Url.new
	end
	
	def create		

		s = generate

		m_url = URI::parse(URI::encode(params[:url][:url]))

		#check if parsed url is URL and then return error or success
		unless m_url.kind_of?URI::HTTP or m_url.kind_of?URI::HTTPS
			flash[:error] = "The URL you entered is not valid."
		else
			#generate random string and add it with url n
			url = Url.create(:url=> Url.clean(params[:url]), :shorten=>s)
			if url.save
				flash[:success] = "The url is created successfully. And shorten url is: "+"http://" + request.env["HTTP_HOST"] + "/" + s
			else
					flash[:error] = "The URL can't be created. Try again!"
			end
		end
		
		redirect_to index_path
	end

	def show
		urls = Url.where(:shorten=>params[:link]).first rescue nil

		if urls.nil? then 
			flash[:error] = "The URL can't be found." 
			redirect_to index_path 
		else 
			redirect_to urls.url 
		end
	end
private
	def generate
			short = (0...6).map { (65 + rand(26)).chr }.join.to_s.downcase
			if Url.where(:shorten=>short).present?
				(0...6).map { (65 + rand(26)).chr }.join.to_s.downcase
			else
				short
			end
		end 
end