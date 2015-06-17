require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @normalUser = FactoryGirl.create(:normalUser)
      @managerUser = FactoryGirl.create(:managerUser)
      @adminUser = FactoryGirl.create(:adminUser)
    end
    context "with normal user" do
      before(:each) do
        sign_in :user, @normalUser
        get :index
      end
      it "responds with 200" do
        expect(response.status).to be 200
      end
      it "gets only current user" do
        expect(json_response[:email]).to eq(@normalUser.email)
      end
      after(:each) do
        sign_out :user
      end
    end
    context "with manager user" do
      before(:each) do
        sign_in :user, @managerUser
        get :index
      end
      it "responds with 200" do
        expect(response.status).to be 200
      end
      it "gets all users" do
        expect(json_response.count).to eq(User.count)
      end
      after(:each) do
        sign_out :user
      end
    end
    context "with admin user" do
      before(:each) do
        sign_in :user, @adminUser
        get :index
      end
      it "responds with 200" do
        expect(response.status).to be 200
      end
      it "gets all users" do
        expect(json_response.count).to eq(User.count)
      end
      after(:each) do
        sign_out :user
      end
    end
  end
  describe "GET #show" do
    before(:each) do
      @normalUser = FactoryGirl.create(:normalUser)
      @managerUser = FactoryGirl.create(:managerUser)
    end
    before(:each) do
      sign_in :user, @normalUser
      get :show, {id: @managerUser }
    end
    it "responds with 200" do
      expect(response.status).to be 200
    end
    it "gets only current user" do
      expect(json_response[:email]).to eq(@managerUser.email)
    end
    after(:each) do
      sign_out :user
    end
  end
end
