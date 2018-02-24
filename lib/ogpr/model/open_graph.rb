# frozen_string_literal: true

require_relative './base.rb'

module Ogpr
  module Model
    class OpenGraph < Base
      def self.create(meta)
        result = meta.select { |k, _| k =~ /^og:\w+/ }
        return nil if result.empty?

        new(result)
      end

      def initialize(hash)
        super hash
        @prefix = 'og'
      end

      def inspect
        "<Ogpr::Model::OpenGraph @meta=#{@meta}>"
      end
    end
  end
end
