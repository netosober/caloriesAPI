require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  include Warden::Test::Helpers

  describe "GET #index" do
    before(:each) do
      @normalUser = FactoryGirl.create(:normalUser)
      @managerUser = FactoryGirl.create(:managerUser)
      @adminUser = FactoryGirl.create(:adminUser)
        login_as(@normalUser, :scope => :user)
    end
    context "with normal user" do
      before(:each) do
        get :index
      end

      it "responds with 200" do
        expect(response.status).to be 200
      end

      it "gets only current user" do
        expect(json_response[:email]).to eq(@normalUser.email)
      end
    end
  end
end
