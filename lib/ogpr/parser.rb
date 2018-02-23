# frozen_string_literal: true

require 'nokogiri'
require_relative './result.rb'

module Ogpr
  class Parser
    class << self
      def parse(str)
        new(str).parse
      end
    end

    def initialize(html)
      @html = html
    end

    def parse
      doc = Nokogiri::HTML(@html, nil, 'utf-8')
      meta = parse_meta(doc)

      Result.new(meta)
    end

    private

    def parse_meta(doc)
      doc.css('meta').map do |elm|
        key = nil
        value = nil
        if (elm['property'] =~ /og:\w+/)
          key = elm['property']
          value = elm['content']
        elsif (elm['name'] =~ /twitter:\w+/)
          key = elm['name']
          # Always value is in 'content',
          # but value is in 'value' property on twitpic...
          value = elm['content'] || elm['value']
        end

        if key.nil? || key.empty? || value.nil? || value.empty?
          {}
        else
          Hash[key, value]
        end
      end.reduce(&:merge)
    end
  end
end
