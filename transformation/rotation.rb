module Transformation
  module Rotation
    module_function
    @theta = 0.0
    @cos = 0.0
    @sin = 0.0

    def matrices
      {
        x: mMATRIX_X,
        y: mMATRIX_Y,
        z: mMATRIX_Z
      }
    end

    def mMATRIX_X
      [
        [1,    0,     0],
        [0, @cos, -@sin],
        [0, @sin,  @cos]
      ]
    end

    def mMATRIX_Y
      [
        [ @cos, 0, @sin],
        [    0, 1,    0],
        [-@sin, 0, @cos]
      ]
    end

    def mMATRIX_Z
      [
        [@cos, -@sin, 0],
        [@sin,  @cos, 0],
        [   0,     0, 1]
      ]
    end

    def matrix(axis, theta)
      set_theta(theta)
      Transformation::Matrix.new(
        matrices.fetch(axis.to_sym)
      )
    end

    def set_theta(theta_in_radian)
      @theta = theta_in_radian
      @cos = Math::cos(@theta)
      @sin = Math::sin(@theta)
    end
  end
end
