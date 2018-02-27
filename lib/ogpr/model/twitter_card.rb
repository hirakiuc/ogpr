# frozen_string_literal: true

require_relative './base.rb'

module Ogpr
  module Model
    class TwitterCard < Base
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
