require 'uri'

class UrlPatternValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, base)
		if value.nil? || value.blank? || !value.kind_of? URI::HTTP || !value.kind_of? URI::HTTPS
			record.errors[attribute] = "Please enter valid url."
		end
	end
end