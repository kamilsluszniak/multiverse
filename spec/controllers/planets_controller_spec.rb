require 'rails_helper'

RSpec.describe PlanetsController, type: :controller do

  describe "GET #summary" do
    it "returns http success" do
      get :summary
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #resources" do
    it "returns http success" do
      get :resources
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #research" do
    it "returns http success" do
      get :research
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #offensive" do
    it "returns http success" do
      get :offensive
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #defensive" do
    it "returns http success" do
      get :defensive
      expect(response).to have_http_status(:success)
    end
  end

end
