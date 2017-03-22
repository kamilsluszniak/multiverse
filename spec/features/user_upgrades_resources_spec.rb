require 'spec_helper'
RSpec.feature "User upgrades" do

    let(:planet) { create(:planet) }
    let(:planet2) { create(:planet2, :metal, :crystal, :hydrogen, :energy) }
    let(:planet_with_resources) { create(:planet, :metal, :crystal, :hydrogen, :energy)}
    let(:user) { sign_in }


    scenario "metal mine without resources" do
      visit resources_planet_path(planet)
      expect(page).to have_content(I18n.t('planet.actions.resources.title'))
      click_button (I18n.t('planet.actions.resources.metal_mine'))
      click_button (I18n.t('planet.actions.resources.upgrade_metal'))
      expect(page).to have_content(I18n.t('planet.actions.resources.upgrading'))
    end
end
