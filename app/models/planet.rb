class Planet < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :system
  validates :name, presence: true, allow_blank: false, length: { maximum: 16 }

  def update_resources
    if self.resources_updated_at
      days = self.resources_updated_at - Time.now
      self.resources_updated_at = Time.now
      self.metal = self.metal_lvl**1.3 * 0.8 * days
      self.crystal = self.crystal_lvl**1.2 * 0.59 * days
      if self.hydrogen_lvl then
        self.hydrogen = self.hydrogen_lvl**1.1* 0.32 * days
      end
      self.energy = self.energy_lvl**1.15 * 40
      self.save!
    end
  end

end
