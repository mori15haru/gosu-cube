require 'gosu'
require_relative 'cube'

class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480
  @@theta = 20 * Math::PI / 180

  attr_reader :cube
  private :cube

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Cube'

    @cube = Cube.new
  end

  def update
    # not in use
  end

  def draw
    cube.draw
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::KbJ # along +x
      cube.rotate('x', theta)
    when Gosu::KbK # along -x
      cube.rotate('x', anti_theta)
    when Gosu::KbH # along +y
      cube.rotate('y', theta)
    when Gosu::KbL # along -y
      cube.rotate('y', anti_theta)
    when Gosu::KbA # along +z
      cube.rotate('z', theta)
    when Gosu::KbS # along -z
      cube.rotate('z', anti_theta)
    when Gosu::KbP # perspective
      cube.update_perspective
    end
  end

  private

  def theta
    @@theta
  end

  def anti_theta
    -@@theta
  end
end

if __FILE__ == $0
  SimWindow.new.show
end
