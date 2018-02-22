# frozen_string_literal: true

require 'uri'
require 'rest-client'
require 'kconv'
require_relative '../logger.rb'

module Ogpr
  class Fetcher
    class HtmlFetcher
      def initialize(uri, options = {})
        @uri = URI.parse(uri)
        @accept_types = %w(text/html text/plain)
        @headers = {}
        @logger = options[:logger] || ::Ogpr::Logger.new(options)
      end

      def head(headers = {})
        send_request(:head, @uri, headers)
      end

      def get(headers = {})
        res = send_request(:get, @uri, headers)
        Kconv.toutf8(res.to_str)
      end

      def fetch(headers = {})
        res = head(headers)
        acceptable_content!(res.headers[:content_type])

        get(headers)
      rescue => e
        raise e
      end

      private

      def acceptable_content!(content_type)
        acceptable = @accept_types.include?(content_type)

        raise "Can't accept content-type: #{content_type}" unless acceptable
      end

      def send_request(method, uri, headers)
        options = request_options(method, uri, headers)
        res = RestClient::Request.execute(options)

        raise "Got http status code(#{res.code}) by #{method} request from #{uri}" unless res.code == 200

        res
      rescue => e
        @logger.warn e
        raise e
      end

      def request_options(method, uri, headers)
        {
          method: method,
          uri: uri.to_s,
          headers: @headers.merge(headers),
          max_redirects: 10,
          verify_ssl: OpenSSL::SSL::VERIFY_NONE,
          timeout: 30
        }
      end
    end
  end
end
