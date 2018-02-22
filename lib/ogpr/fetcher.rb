# frozen_string_literal: true

require 'uri'
require_relative './logger.rb'
require_relative './fetcher/html_fetcher.rb'

module Ogpr
  class Fetcher
    def self.fetch(url, options)
      HtmlFetcher.new(url, options).fetch()
    end
  end
end
