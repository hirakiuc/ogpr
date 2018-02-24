# frozen_string_literal: true

module Ogpr
  module Model
    class Base < BasicObject
      attr_reader :meta, :type

      def initialize(hash)
        @meta = hash
        @type = nil

        @key = nil
      end

      %w(title description url image).each do |attr|
        define_method attr.to_sym do
          @meta["#{@key}:#{attr}"]
        end
      end

      def keys
        @meta.keys.map { |v| v.gsub /^#{@key}:/, '' }.sort
      end

      def each_key
        return unless block_given?
        keys.each { |key| yield key }
      end

      def each_pair
        return unless block_given?
        keys.each { |key| yield key, @meta["#{@key}:#{key}"] }
      end

      def to_s
        @meta.to_s
      end

      def method_missing(name)
        super unless @meta.key?("#{@key}:#{name}")
        @meta["#{@key}:#{name}"]
      end

      def respond_to_missing?(name, include_private = false)
        @meta.key?("#{@key}:#{name}") or super
      end
    end
  end
end
