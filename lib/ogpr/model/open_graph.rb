# frozen_string_literal: true

require_relative './base.rb'

module Ogpr
  module Model
    class OpenGraph < Base
      def self.create(meta)
        new(meta)
      rescue
        nil
      end

      def initialize(hash)
        super hash.select { |k, _| k =~ /^og:\w+/ }
        @prefix = 'og'
      end

      def type
        @meta['og:type']
      end
    end
  end
end
