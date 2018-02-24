# frozen_string_literal: true

require_relative './model/open_graph.rb'
require_relative './model/twitter_card.rb'

module Ogpr
  class Result
    attr_reader :open_graph, :twitter_card

    def initialize(meta)
      @open_graph = Model::OpenGraph.create(meta.select { |k, _| k =~ /^og:\w+/ })
      @twitter_card = Model::TwitterCard.create(meta.select { |k, _| k =~ /^twitter:\w+/ })
      @meta = meta
    end

    def exist?
      !@open_graph.nil? || !@twitter_card.nil?
    end

    def open_graph!
      raise 'OpenGraph does not found.' unless @open_graph
      @open_graph
    end

    def twitter_card!
      raise 'TwitterCard does not found.' unless @twitter_card
      @twitter_card
    end

    def to_s
      @meta.to_s
    end

    def inspect
      "<Ogpr::Result @meta=#{self.to_s}, @open_graph=#{self.open_graph.inspect}, @twitter_card=#{self.twitter_card.inspect}>"
    end
  end
end
