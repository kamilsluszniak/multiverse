require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'database columns' do
    it { should have_db_column :name }
    it { should have_db_column :user_id }
  end

  describe 'associations' do
  	it { is_expected.to belong_to :user}
  end
end
