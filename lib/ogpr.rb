# frozen_string_literal: true

require 'ogpr/version'
require_relative './ogpr/fetcher.rb'
require_relative './ogpr/parser.rb'

module Ogpr
  class << self
    # Fetch the url and parse meta data.
    def fetch(url, options = {})
      result = Fetcher.fetch(url, options)

      Parser.parse(result.to_s)
    end

    # Parse the string
    def parse(str, options = {})
      Parser.parse(str, options)
    end
  end
end
