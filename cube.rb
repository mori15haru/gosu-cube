require 'gosu'

require_relative 'display'
require_relative 'vector'
require_relative 'transformation/projection'
require_relative 'transformation/rotation'
require_relative 'transformation/coordinate'

class Cube
  #Variables for visualising
  FROM = 0
  TO = 1

  @@l = 50
  @@edges = [
    [0, 1], [1, 3], [2, 3], [0, 2],
    [2, 6], [6, 7], [3, 7], [0, 4],
    [1, 5], [4, 5], [5, 7], [4, 6]
  ]
  @@surfaces = [
    [1, 3, 2, 0],
    [0, 2, 6, 4],
    [4, 6, 7, 5],
    [5, 7, 3, 1],
    [4, 5, 1, 0],
    [7, 6, 2, 3]
  ]

  def initialize
    @vertices = [-@@l, @@l].repeated_permutation(3).to_a
    @perspective = false
    @view_vec = Vec.new([0, 0, -1])
  end

  def draw
    #draw_vertices
    draw_edges
  end

  def rotate(axis, theta)
    Transformation::Rotation.matrix(axis, theta).tap do |mRotate|
      @vertices.map! { |v| mRotate * v }
    end
  end

  def update_perspective
    @perspective = !@perspective
   end

  private

  def projection
    if @perspective
      Transformation::Projection::Perspective
    else
      Transformation::Projection::Orthographic
    end
  end

  def draw_vertices
    vertices_to_render.each { |v| Display::Draw::point(v) }
  end

  def draw_edges
    @@edges.each do |e|
      surfaces_to_render.each do |surface|
        if surface.include?(e[FROM]) && surface.include?(e[TO])
          Display::Draw::line(vertices_to_render[e[FROM]], vertices_to_render[e[TO]])
        end
      end
    end
  end

  def vertices_to_render
    # gosu coordinate
    vertices_projected.map { |v| Transformation::GosuCoordinate.matrix * (v << 1) }
  end

  def vertices_projected
    # apply perspective/orthographic projection
    @vertices.map { |v| projection.matrix(v) * v }
  end

  def surfaces_to_render
    @@surfaces.select do |surface|
      s1, s2, s3, s4 = surface
      p1 = vertices_projected[s1]
      p2 = vertices_projected[s2]
      p3 = vertices_projected[s3]
      p4 = vertices_projected[s4]
      v1 = Vec.new(p1) - Vec.new(p2)
      v2 = Vec.new(p2) - Vec.new(p3)
      _n = v1.outer_prod(v2)
      _c = _n.inner_prod(@view_vec)
      _c > 0
      # or n * view_vec > 0
    end
  end
end
