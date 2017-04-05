class Planet < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :system
  validates :name, presence: true, allow_blank: false, length: { maximum: 16 }
  before_create :set_ready_to_now

  def update_resources
    if self.resources_updated_at
      seconds = Time.now - self.resources_updated_at
      self.resources_updated_at = Time.now
      power_consumption = 10*self.metal_lvl*(1.1**self.metal_lvl) + 10*self.crystal_lvl*(1.1**self.crystal_lvl)
        + 20*self.hydrogen_lvl*(1.1**self.hydrogen_lvl)
      efficiency = (self.energy >= power_consumption) ? 1 : (self.energy / power_consumption)
      self.metal = self.metal + self.metal_lvl*(1.1**self.metal_lvl) * 0.0083333 * seconds * efficiency
      self.crystal = self.crystal + self.crystal_lvl*(1.1**self.crystal_lvl) * 0.005555556 * seconds * efficiency
      if self.hydrogen_lvl then
        self.hydrogen = self.hydrogen + self.hydrogen_lvl*(1.1**self.hydrogen_lvl) * 0.00277778 * seconds * efficiency
      end
      self.energy = self.solar_lvl**1.15 * 40
    end
  end

  def update_resources!
    if self.resources_updated_at
      seconds = Time.now - self.resources_updated_at
      self.resources_updated_at = Time.now
      power_consumption = 10*self.metal_lvl*(1.1**self.metal_lvl) + 10*self.crystal_lvl*(1.1**self.crystal_lvl)
        + 20*self.hydrogen_lvl*(1.1**self.hydrogen_lvl)
      efficiency = (self.energy >= power_consumption) ? 1 : (self.energy / power_consumption)
      self.metal = self.metal + self.metal_lvl*(1.1**self.metal_lvl) * 0.0083333 * seconds * efficiency
      self.crystal = self.crystal + self.crystal_lvl*(1.1**self.crystal_lvl) * 0.005555556 * seconds * efficiency
      if self.hydrogen_lvl then
        self.hydrogen = self.hydrogen + self.hydrogen_lvl*(1.1**self.hydrogen_lvl) * 0.00277778 * seconds * efficiency
      end
      self.energy = self.solar_lvl**1.15 * 40
      self.save!
    end
  end

  def upgrade_metal
    self.update_resources
    metal = self.metal
    crystal = self.crystal
    lvl = self.metal_lvl
    cost = calc_metal_cost(lvl)
    if (cost[:metal_cost] <= metal) && (cost[:crystal_cost] <= crystal)
      self.metal = metal - metal_cost
      self.crystal = crystal - crystal_cost
      self.metal_lvl = lvl + 1
      self.metal_rdy_at = Time.now + building_calc_build_time(cost[:metal_cost], cost[:crystal_cost])
      self.save!
    else
      return false
    end
  end

  def upgrade_crystal
    self.update_resources
    metal = self.metal
    crystal = self.crystal
    lvl = self.crystal_lvl
    cost = calc_crystal_cost(lvl)
    if (cost[:metal_cost] <= metal) && (cost[:crystal_cost] <= crystal)
      self.metal = metal - cost
      self.crystal = crystal - cost
      self.crystal_lvl = lvl + 1
      self.crystal_rdy_at = Time.now + building_calc_build_time(cost[:metal_cost], cost[:crystal_cost])
      self.save!
    else
      return false
    end
  end

  def upgrade_hydrogen
    self.update_resources
    metal = self.metal
    crystal = self.crystal
    lvl = self.hydrogen_lvl
    cost = calc_hydrogen_cost(lvl)
    if (cost[:metal_cost] <= metal) && (cost[:crystal_cost] <= crystal)
      self.metal = metal - cost
      self.crystal = crystal - cost
      self.hydrogen_lvl = lvl + 1
      self.hydrogen_rdy_at = Time.now + building_calc_build_time(cost[:metal_cost], cost[:crystal_cost])
      self.save!
    else
      return false
    end
  end

  def upgrade_solar
    self.update_resources
    metal = self.metal
    crystal = self.crystal
    lvl = self.solar_lvl
    cost = calc_solar_cost(lvl)
    if (cost[:metal_cost] <= metal) && (cost[:crystal_cost] <= crystal)
      self.metal = metal - cost
      self.crystal = crystal - cost
      self.solar_lvl = lvl + 1
      self.solar_rdy_at = Time.now + building_calc_build_time(cost[:metal_cost], cost[:crystal_cost])
      self.save!
    else
      return false
    end
  end

  def set_ready_to_now
    self.metal_rdy_at = Time.now
    self.crystal_rdy_at = Time.now
    self.solar_rdy_at = Time.now
    self.hydrogen_rdy_at = Time.now
  end

  def building_calc_build_time(metal_cost, crystal_cost)
    (metal_cost + crystal_cost)/15
  end

  def calc_metal_cost(lvl)
    metal_cost = 60 * 1.5**lvl
    crystal_cost = 45 * 1.5**lvl
    return {:metal_cost => metal_cost, :crystal_cost => crystal_cost}
  end

  def calc_crystal_cost(lvl)
    metal_cost = 48 * 1.6**lvl
    crystal_cost = 23 * 1.6**lvl
    return {:metal_cost => metal_cost, :crystal_cost => crystal_cost}
  end

  def calc_hydrogen_cost(lvl)
    metal_cost = 225 * 1.5**lvl
    crystal_cost = 75 * 1.5**lvl
    return {:metal_cost => metal_cost, :crystal_cost => crystal_cost}
  end

  def calc_solar_cost(lvl)
    metal_cost = 225 * 1.5**lvl
    crystal_cost = 75 * 1.5**lvl
    return {:metal_cost => metal_cost, :crystal_cost => crystal_cost}
  end

end
