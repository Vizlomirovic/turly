class UrlsController < ApplicationController
	def index
		@url = Url.new
		@urls = Url.all
	end
	
	def create
		url = Url.new

		unless Url.isUrl?(params[:url])
				flash[:error] = "The input field can't be empty."
		else
				s = (0...6).map { (65 + rand(26)).chr }.join.to_s

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