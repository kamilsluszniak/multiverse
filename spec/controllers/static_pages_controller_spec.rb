require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  let(:user) { create :user }

  before { sign_in user }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #welcome" do
    it "returns http success" do
     get :welcome
      expect(response).to have_http_status(:success)
    end
  end

end
