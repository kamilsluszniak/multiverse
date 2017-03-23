require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should_not allow_value("", nil).for(:name) }
    it { should validate_length_of(:name).is_at_most(16) }
  end

  describe 'database columns' do
    it { should have_db_column :name }
    it { should have_db_column :user_id }
    it { should have_db_column :metal }
    it { should have_db_column :crystal }
    it { should have_db_column :hydrogen }
    it { should have_db_column :energy }
    it { should have_db_column :resources_updated_at }
    it { should have_db_column :metal_rdy_at }
    it { should have_db_column :crystal_rdy_at }
    it { should have_db_column :hydrogen_rdy_at }
    it { should have_db_column :solar_rdy_at }
  end

  describe 'associations' do
  	it { is_expected.to belong_to :user}
  end
end
