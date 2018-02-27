# frozen_string_literal: true

require_relative './model/open_graph.rb'
require_relative './model/twitter_card.rb'

module Ogpr
  class Result
    attr_reader :open_graph, :twitter_card

    def initialize(meta)
      @open_graph = Model::OpenGraph.create(meta)
      @twitter_card = Model::TwitterCard.create(meta)
      @meta = meta
    end

    def exist?
      !@open_graph.nil? || !@twitter_card.nil?
    end

    def open_graph!
      raise 'OpenGraph does not found' unless @open_graph
      @open_graph
    end

    def open_graph?
      @open_graph != nil
    end

    def twitter_card!
      raise 'TwitterCard does not found' unless @twitter_card
      @twitter_card
    end

    def twitter_card?
      @twitter_card != nil
    end

    def to_s
      "#<Ogpr::Result:#{object_id} @open_graph=#{@open_graph}, @twitter_card=#{@twitter_card}>"
    end
  end
end
