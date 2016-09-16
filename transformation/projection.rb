require_relative 'matrix'
# require ^ only once?

module Transformation
  module Projection
    module Perspective
      module_function
      @f = 0.0

      def mMATRIX
        [
          [@f,  0, 0],
          [ 0, @f, 0],
          [ 0,  0, 1]
        ]
      end

      def matrix(v)
        set_f(v)
        Transformation::Matrix.new(mMATRIX)
      end

      def set_f(v)
        @f = 400 / (v[2] + 200)
      end
    end

    module Orthographic
      module_function
      def matrix(v)
        Transformation::Matrix.identity
      end
    end
  end
end
