require 'rails_helper'

RSpec.describe PlanetsController, type: :controller do

  context "when logged in" do
    let(:user) { create(:user) }
    let(:planet) { create(:planet, user: user) }

    before :each do
      login_with user
    end

    it "returns http success on GET #index" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success on GET #resources" do
      puts @planet.inspect
      puts @planet
      puts "planettttt"
      get :resources, params: {:id => planet.id}
      expect(response).to have_http_status(:success)
    end

    #it "returns http success on GET #research" do
    #  get :research
    #  expect(response).to have_http_status(:success)
    #end

    #it "returns http success on GET #offensive" do
    #  get :offensive
    #  expect(response).to have_http_status(:success)
    #end

    #it "returns http success on GET #defensive" do
    #  get :defensive
    #  expect(response).to have_http_status(:success)
    #end
  end

  context "when not logged in" do
    before :each do
      login_with nil
    end

    it "redirects GET #index" do
      get :index
      expect(response).to redirect_to( new_user_session_path )
    end

    it "redirects GET #resources" do
      get :resources, params: {:id => 1}
      expect(response).to redirect_to( new_user_session_path )
    end
  end

end
