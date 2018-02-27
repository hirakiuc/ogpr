# frozen_string_literal: true

require_relative './base.rb'

module Ogpr
  module Model
    class TwitterCard < Base
      def self.create(meta)
        new(meta)
      rescue
        nil
      end

      def initialize(hash)
        super hash.select { |k, _| k =~ /^twitter:\w+/ }
        @prefix = 'twitter'
      end

      def type
        @meta['twitter:card']
      end
    end
  end
end
