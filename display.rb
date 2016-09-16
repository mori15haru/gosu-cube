module Display
  module Draw
    module_function
    @@colour = Gosu::Color::WHITE

    def point(v)
      x, y, z = v
      Gosu::draw_rect(x, y, 5, 5, @@colour)
    end

    def line(v, u)
      x1, y1, z1 = v
      x2, y2, z2 = u

      Gosu::draw_line(x1, y1, @@colour, x2, y2, @@colour)
    end
  end
end
