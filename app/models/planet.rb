class Planet < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :system
  validates :name, presence: true, allow_blank: false, length: { maximum: 16 }

  def update_resources
    if self.resources_updated_at
      seconds = Time.now - self.resources_updated_at
      self.resources_updated_at = Time.now
      self.metal = self.metal + self.metal_lvl**1.3 * 0.03333 * seconds
      self.crystal = self.crystal + self.crystal_lvl**1.2 * 0.02456 * seconds
      if self.hydrogen_lvl then
        self.hydrogen = self.hydrogen + self.hydrogen_lvl**1.1* 0.013333 * seconds
      end
      self.energy = self.solar_lvl**1.15 * 40
      self.save!
    end
  end

end
