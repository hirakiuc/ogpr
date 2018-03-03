# frozen_string_literal: true

require_relative './result.rb'

module Ogpr
  class Loader
    class << self
      def load(hash)
        Result.new(hash)
      end
    end
  end
end
