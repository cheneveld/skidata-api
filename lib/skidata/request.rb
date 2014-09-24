require 'openssl'
require 'base64'

module Skidata
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper)
      request(:get, path, options, signature, raw, unformatted, no_response_wrapper)
    end

    # Perform an HTTP POST request
    def post(path, options={}, signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper)
      request(:post, path, options, signature, raw, unformatted, no_response_wrapper)
    end

    # Perform an HTTP PUT request
    def put(path, options={},  signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper)
      request(:put, path, options, signature, raw, unformatted, no_response_wrapper)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper)
      request(:delete, path, options, signature, raw, unformatted, no_response_wrapper)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, signature=false, raw=false, unformatted=false, no_response_wrapper=false)

      headers = {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent, 'Cookie' => "#{options[:validation_cookie]}"}

      #puts headers.inspect

      request_path = endpoint + path

      #puts request_path
      
      response = case method
        when :get
          HTTParty.get(request_path, :headers => headers, :verify => false)
        when :post
          HTTParty.post(request_path, :body => options, :headers => headers, :verify => false)
        when :put
        when :delete
        end

        return response
      # return response if raw
      # return response.body if no_response_wrapper
      # return Response.create( response.body )
    end
  end
end