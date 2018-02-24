# frozen_string_literal: true

require_relative './base.rb'

module Ogpr
  module Model
    class TwitterCard < Base
      def self.create(meta)
        result = meta.select { |k, _| k =~ /^twitter:\w+/ }
        return nil if result.empty?

        new(meta)
      end

      def initialize(hash)
        super hash
        @key = 'twitter'
      end
    end
  end
end
