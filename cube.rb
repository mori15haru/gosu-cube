require 'gosu'
require_relative 'display'
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

  def initialize
    @vertices = [-@@l, @@l].repeated_permutation(3).to_a
    @perspective = false
  end

  def draw
    draw_vertices
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
    @@edges.each { |e| Display::Draw::line(vertices_to_render[e[FROM]], vertices_to_render[e[TO]]) }
  end

  def vertices_to_render
    # gosu coordinate
    vertices_projected.map { |v| Transformation::GosuCoordinate.matrix * (v << 1) }
  end

  def vertices_projected
    # apply perspective/orthographic projection
    @vertices.map { |v| projection.matrix(v) * v }
  end
end
