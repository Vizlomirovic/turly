class Url < ActiveRecord::Base
	validates :url, presence: true

	def self.clean(url)
		URI::parse(URI::encode(url[:url])).normalize.to_s
	end

	def self.generate
			short = (0...6).map { (65 + rand(26)).chr }.join.to_s.downcase
			if Url.where(:shorten=>short).present?
				(0...6).map { (65 + rand(26)).chr }.join.to_s.downcase
			else
				short
			end
		end 
end