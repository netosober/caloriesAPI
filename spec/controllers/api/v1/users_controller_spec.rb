require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) do
    @normal_user = FactoryGirl.create(:normal)
    @manager_user = FactoryGirl.create(:manager)
    @admin_user = FactoryGirl.create(:admin)
    @other_user_attr = FactoryGirl.attributes_for(:other)
  end
  describe "GET #index" do
    context "with normal user" do
      before(:each) do
        sign_in :user, @normal_user
        get :index
      end
      it "responds with 200" do
        expect(response.status).to be 200
      end
      it "gets only current user" do
        expect(json_response[:email]).to eq(@normal_user.email)
      end
      after(:each) do
        sign_out :user
      end
    end
    context "with manager user" do
      before(:each) do
        sign_in :user, @manager_user
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
        sign_in :user, @admin_user
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
      sign_in :user, @normal_user
      get :show, {id: @manager_user }
    end
    it "responds with 200" do
      expect(response.status).to be 200
    end
    it "gets only current user" do
      expect(json_response[:email]).to eq(@manager_user.email)
    end
    after(:each) do
      sign_out :user
    end
  end
  describe "POST #create" do
    context "with normal user" do
      before(:each) do
        sign_in :user, @normal_user
        post :create, user: @other_user_attr
      end
      it "responds with 401" do
        expect(response.status).to be 401
      end
      it "error is unauthorized" do
        expect(json_response[:error]).to eq('unauthorized')
      end
    end
    context "with manager user" do
      before(:each) do
        sign_in :user, @manager_user
        post :create, user: @other_user_attr
      end
      it "responds with 201" do
        expect(response.status).to be 201
      end
      it "returns new user" do
        expect(json_response[:email]).to eq(@other_user_attr[:email])
      end
    end
    context "with admin user" do
      before(:each) do
        sign_in :user, @admin_user
        post :create, user: @other_user_attr
      end
      it "responds with 201" do
        expect(response.status).to be 201
      end
      it "creates new user" do
        last_user = User.find_by_email(@other_user_attr[:email])
        expect(last_user.email).to eq(@other_user_attr[:email])
      end
    end
  end
end
