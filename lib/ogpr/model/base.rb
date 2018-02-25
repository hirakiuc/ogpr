# frozen_string_literal: true

module Ogpr
  module Model
    class Base
      attr_reader :meta

      def initialize(hash)
        @meta = hash
        @prefix = nil
      end

      %w(title description url image).each do |attr|
        define_method attr.to_sym do
          @meta[with_prefix(attr)]
        end
      end

      def [](key)
        @meta[with_prefix(key)]
      end

      def keys
        @meta.keys.map { |v| strip_prefix(v) }.sort
      end

      # rubocop:disable Performance/HashEachMethods
      def each_key(&block)
        return unless block
        keys.each { |key| yield key }
      end

      def each_pair(&block)
        return unless block
        keys.each { |key| yield key, @meta[with_prefix(key)] }
      end
      # rubocop:enable Performance/HashEachMethods

      def to_s
        @meta.to_s
      end

      private

      def strip_prefix(key)
        if key.to_s.start_with?(@prefix)
          key.to_s.gsub(/^#{@prefix}:/, '')
        else
          key.to_s
        end
      end

      def with_prefix(key)
        if key.to_s.start_with?(@prefix)
          key.to_s
        else
          @prefix + ':' + key.to_s
        end
      end
    end
  end
end
