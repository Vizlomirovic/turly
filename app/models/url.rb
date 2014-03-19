class Url < ActiveRecord::Base
	validates :url, presence: true

	def self.clean(url)
		URI::parse(URI::encode(url[:url])).normaslize.to_s
	end
end