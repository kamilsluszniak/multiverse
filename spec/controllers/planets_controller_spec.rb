require 'rails_helper'

RSpec.describe PlanetsController, type: :controller do

  describe "GET pages when logged in" do
    before :each do
      login_with create( :user )
    end

    it "returns http success on GET #index" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success on GET #resources" do
      get :resources, params: {:id => 1}
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

  describe "redirects when not logged in" do
    before :each do
      login_with nil
    end

    it "returns http success on GET #index" do
      get :index
      expect(response).to redirect_to( new_user_session_path )
    end

    it "returns http success on GET #resources" do
      get :resources, params: {:id => 1}
      expect(response).to redirect_to( new_user_session_path )
    end
  end

end
