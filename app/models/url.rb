require 'uri'

class Url < ActiveRecord::Base
	validates :url, presence: true


	def self.isUrl?(url)
    if url.blank?
    	nil
    else
    	m_url = URI::parse(URI::encode(url[:url]))
    	unless m_url.kind_of? URI::HTTP or m_url.kind_of? URI::HTTPS
				false
			else
				true
			end
    end

		
	end

	def self.clean(url)
		URI::parse(URI::encode(url[:url])).normalize.to_s
	end

	def self.generate!(orig_url)

	end
end