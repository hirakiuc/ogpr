# frozen_string_literal: true

require 'ogpr/version'
require_relative './ogpr/fetcher.rb'
require_relative './ogpr/loader.rb'
require_relative './ogpr/parser.rb'

module Ogpr
  class << self
    # Fetch the url and parse meta data.
    #
    # @param url [String] the target URL to fetch TwitterCard/OpenGraph meta tags from.
    # @return [Ogpr::Result] the result object which contains TwitterCard/OpenGraph tags.
    def fetch(url, options = {})
      result = Fetcher.fetch(url, options)

      Parser.parse(result.to_s)
    end

    # Load the hash object
    #
    # @param hash [Hash] hash object which contains TwitterCard/OpenGraph tags.
    # @return [Ogpr::Result] the result object which contains TwitterCard/OpenGraph tags.
    def load(hash)
      Loader.load(hash)
    end

    # Parse the string
    #
    # @param str [String] html string which contains TwitterCard/OpenGraph meta tags.
    # @return [Ogpr::Result] the result object which contains TwitterCard/OpenGraph tags.
    def parse(str)
      Parser.parse(str)
    end
  end
end
