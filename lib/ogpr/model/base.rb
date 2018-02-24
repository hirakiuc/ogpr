# frozen_string_literal: true

module Ogpr
  module Model
    class Base
      attr_accessor :title, :desc, :url, :image
      attr_reader :meta, :type

      def initialize(hash)
        @meta = hash
        @type = nil
      end

      def to_s
        @meta.to_s
      end
    end
  end
end
