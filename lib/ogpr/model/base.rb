# frozen_string_literal: true

module Ogpr
  module Model
    class Base
      attr_reader :meta

      def self.create(meta)
        new(meta)
      rescue
        nil
      end

      def initialize(hash)
        @meta = hash
        @prefix = nil

        raise 'Meta is empty' if @meta.empty?
      end

      %w(title description url image).each do |attr|
        define_method attr.to_sym do
          @meta["#{@prefix}:#{attr}"]
        end
      end

      def [](key)
        @meta[key]
      end

      def keys
        @meta.keys.sort
      end

      def each_key(&block)
        return unless block
        @meta.each_key { |key| yield key }
      end

      def each_pair(&block)
        return unless block
        @meta.each_pair { |k, v| yield k, v }
      end

      def to_s
        "#<#{self.class}::#{object_id} @meta=#{@meta}>"
      end
    end
  end
end
