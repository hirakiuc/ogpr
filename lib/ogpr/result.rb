# frozen_string_literal: true

module Ogpr
  class Result
    attr_reader :open_graph, :twitter_card

    def initialize(meta)
      @open_graph = nil
      @twitter_card = nil
      @meta = meta
    end

    def to_s
      @meta.to_s
    end
  end
end
