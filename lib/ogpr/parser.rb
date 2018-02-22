# frozen_string_literal: true

module Ogpr
  class Parser
    class << self
      def parse(str, options = {})
        parser = new(str)
        doc = Nokogiri::HTML(html, nil, 'ut-8')
        meta = parse_meta(doc)
      end
    end

    def initialize(html)
      @html = html
    end

    def parse
      doc = Nokogiri::HTML(html, nil, 'utf-8')
      meta = parse_meta(doc)

      Ogpr::Result.new(meta)
    end

    private

    def parse_meta(doc)
      # TODO refactoring
      meta = {}
      doc.css('meta').each do |elm|
        key = nil, value = nil
        if (elm['property'] =~ /og:\w+/)
          key = elm['property']
          value = elm['content']
        elsif (elm['name'] =~ /twitter:\w+/)
          key = elm['name']
          # Always value is in 'content',
          # but value is in 'value' property on twitpic...
          value = elm['content'] || elm['value']
        end

        next if key.blank? or value.blank?
        meta[key] = value
      end
    end
  end
end
