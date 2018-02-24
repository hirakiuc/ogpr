# frozen_string_literal: true

module Ogpr
  module Model
    class Base < BasicObject
      attr_reader :meta, :type

      def initialize(hash)
        @meta = hash
        @type = nil

        @prefix = nil
      end

      %w(title description url image).each do |attr|
        define_method attr.to_sym do
          @meta[with_prefix(attr)]
        end
      end

      def keys
        @meta.keys.map { |v| strip_prefix(v) }.sort
      end

      def each_key
        return unless block_given?
        keys.each { |key| yield key }
      end

      def each_pair
        return unless block_given?
        keys.each { |key| yield key, @meta[with_prefix(key)] }
      end

      def to_s
        @meta.to_s
      end

      def method_missing(name)
        super unless @meta.key?(with_prefix(name))
        @meta[with_prefix(name)]
      end

      def respond_to_missing?(name, include_private = false)
        @meta.key?(with_prefix(name)) or super
      end

      private

      def strip_prefix(key)
        if (key.to_s).start_with?(@prefix)
          (key.to_s).gsub(/^#{@prefix}:/, '')
        else
          key.to_s
        end
      end

      def with_prefix(key)
        if (key.to_s).start_with?(@prefix)
          key.to_s
        else
          @prefix + ':' + key.to_s
        end
      end
    end
  end
end
