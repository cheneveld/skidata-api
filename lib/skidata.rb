require File.expand_path('../skidata/error', __FILE__)
require File.expand_path('../skidata/configuration', __FILE__)
require File.expand_path('../skidata/api', __FILE__)
require File.expand_path('../skidata/client', __FILE__)
require File.expand_path('../skidata/acts_as_tableless_skidata_user', __FILE__)
module Skidata
	extend Configuration

	# Alias for Skidata::Client.new
	#
	# @return [Skidata::Client]
	def self.client(options={})
		Skidata::Client.new(options)
	end

	# Delegate to Skidata::Client
	def self.method_missing(method, *args, &block)
		return super unless client.respond_to?(method)
		client.send(method, *args, &block)
	end

	# Delegate to Skidata::Client
	def self.respond_to?(method, include_all=false)
		return client.respond_to?(method, include_all) || super
	end
end
