require 'spec_helper'
RSpec.feature "User upgrades" do

    let(:user) { create(:user)}
    let(:planet) { create(:planet, user: user) }
    let(:planet2) { create(:planet2, :metal, :crystal, :hydrogen, :energy) }
    let(:planet_with_resources) { create(:planet, :metal, :crystal, :hydrogen, :energy, user: user)}


    scenario "metal mine without resources", js: true do
      sign_in(user)
      visit resources_planet_path(planet)
      expect(page).to have_content(I18n.t('planet.actions.resources.title'))
      click_on (I18n.t('planet.actions.resources.metal_mine'))
      expect(page).to have_css("#object-name", text: "metal")
      click_link (I18n.t('common.upgrade'))
      expect(page).to have_content(I18n.t('common.no-resources'))
    end


end
