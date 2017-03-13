require 'rails_helper'

RSpec.describe System, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'database columns' do
    it { should have_db_column :name }
  end

  describe 'associations' do
  	it { is_expected.to have_many :planets}
  end
end
