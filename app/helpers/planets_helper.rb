module PlanetsHelper
  class PlanetObject
    attr_accessor :lvl
    attr_accessor :name
    attr_accessor :time
    attr_accessor :cost

    def initialize
      @lvl = nil
      @name = nil
      @time = nil
      @cost = nil
    end

  end
end
