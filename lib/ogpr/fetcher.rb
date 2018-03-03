# frozen_string_literal: true

require 'uri'
require_relative './fetcher/html_fetcher.rb'

module Ogpr
  class Fetcher
    def self.fetch(url)
      HtmlFetcher.new(url).fetch
    end
  end
end
