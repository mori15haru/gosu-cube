module Transformation
  module GosuCoordinate
    module_function
    def mMATRIX
      [
        [1,  0, 0, 320],
        [0, -1, 0, 240],
        [1,  0, 0,   0]
      ]
    end

    def matrix
      Transformation::Matrix.new(mMATRIX)
    end
  end
end
