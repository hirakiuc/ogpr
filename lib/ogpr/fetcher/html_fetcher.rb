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
        @logger = options[:logger] || ::Ogpr::Logger.new($stdout)
      end

      def fetch(headers = {})
        head = send_request(:head, @uri, headers)
        acceptable_content!(head.headers[:content_type])

        res = send_request(:get, @uri, headers)
        Kconv.toutf8(res.to_str)
      rescue => e
        raise e
      end

      private

      def acceptable_content!(content_type)
        parts = content_type.split(';').map(&:strip)
        return if parts.any? { |v| @accept_types.include?(v) }

        raise "Can't accept content-type: #{content_type}"
      end

      def send_request(method, uri, headers)
        RestClient::Request.execute(
          request_options(method, uri, headers)
        )
      rescue RestClient::ExceptionWithResponse => e
        raise "Got http status code(#{e.response.code}) by #{method} request from #{uri}"
      rescue => e
        @logger.warn e
        raise e
      end

      def request_options(method, uri, headers)
        {
          method: method,
          url: uri.to_s,
          headers: @headers.merge(headers),
          max_redirects: 10,
          verify_ssl: OpenSSL::SSL::VERIFY_NONE,
          timeout: 30
        }
      end
    end
  end
end
