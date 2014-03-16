require 'uri'

class UrlsController < ApplicationController
	def index
		@url = Url.new
	end
	
	def create		
		s = (0...6).map { (65 + rand(26)).chr }.join.to_s.downcase

		m_url = URI::parse(URI::encode(params[:url][:url]))
		unless m_url.kind_of?URI::HTTP or m_url.kind_of?URI::HTTPS
			flash[:error] = "The URL you entered is not valid."
		else
			url = Url.create(:url=> Url.clean(params[:url]), :shorten=>s)
			url.save
			flash[:success] = "The url is created successfully. And shorten url is: "+"http://" + request.env["HTTP_HOST"] + "/" + s
		end
	
	
		
		redirect_to index_path
	end

	def show
		urls = Url.where(:shorten=>params[:link]).first
		redirect_to urls.url
	end
end