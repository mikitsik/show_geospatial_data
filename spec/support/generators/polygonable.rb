require "rgeo"

# This module generates wkt_polygon coordinates close to real life conditions
module Polygonable
  def self.call
    factory = RGeo::Geographic.simple_mercator_factory
    num_points = Faker::Number.between(from: 3, to: 10)

    # Generate initial coordinates
    x = Faker::Number.decimal(l_digits: 3, r_digits: 6).to_f
    y = Faker::Number.decimal(l_digits: 3, r_digits: 6).to_f
    initial_point = factory.point(x, y)

    polygon_coordinates = [initial_point]

    (num_points - 1).times do
      # Generate a point within 100 meters
      angle = rand * 2.0 * Math::PI # Allows us to generate random nearby points in a circular area
      dx = 0.1 * Math.cos(angle) # 0.001 in coordinates roughly equals 100 meters
      dy = 0.1 * Math.sin(angle)

      nearby_point = factory.point(x + dx, y + dy)
      polygon_coordinates << nearby_point

      # Update the x and y coordinates for next point generation
      x, y = x + dx, y + dy
    end

    # Create a polygon using the generated coordinates
    factory.polygon(factory.linear_ring(polygon_coordinates)).to_s
  end
end
