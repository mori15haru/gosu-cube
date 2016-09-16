module Transformation
  class Matrix
    attr_reader :matrix
    private :matrix

    def initialize(matrix)
      @matrix = matrix
    end

    def self.identity
      new(
        [
          [1, 0, 0],
          [0, 1, 0],
          [0, 0, 1]
        ]
      )
    end

    def *(vector)
      matrix.map { |u| u.zip(vector).map{ |i, j| i*j }.inject(:+) }
    end
  end
end
