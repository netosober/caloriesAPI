require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do
  render_views
  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @user = FactoryGirl.create(:user)
    @manager = FactoryGirl.create(:manager)
    @normal_profile = FactoryGirl.create(:normal_profile, user: @user)
    @manager_profile = FactoryGirl.create(:manager_profile, user: @manager)
  end

  describe "GET #index" do
    context "with manager signed in" do
      before(:each) do
        sign_in @manager
        get :index
      end
      it "responds with 200" do
        expect(response.status).to be 200
      end
      it "gets all items" do
        expect(json_response[:profiles].count).to eq(Profile.count)
      end
    end
    context "with normal user signed in" do
      before(:each) do
        sign_in @user
        get :index
      end
      it "responds with 200" do
        expect(response.status).to be 200
      end
      it "gets only one profile" do
        expect(json_response[:profiles].count).to eq(1)
      end
      it "returns current user profile" do
        expect(json_response[:profiles][0][:name]).to eq(@normal_profile.name)
      end
    end
  end

  describe "GET #show" do
    context "with manager signed in" do
      before(:each) do
        sign_in @manager
      end
      it "gets own profile" do
        get :show, id: @manager_profile.id
        expect(response.status).to be 200
        expect(json_response[:profile][:name]).to eq(@manager_profile.name)
      end
      it "gets other profiles" do
        get :show, id: @normal_profile.id
        expect(response.status).to be 200
        expect(json_response[:profile][:name]).to eq(@normal_profile.name)
      end
    end
    context "with normal user signed in" do
      before(:each) do
        sign_in @user
      end
      it "gets own profile" do
        get :show, id: @normal_profile.id
        expect(response.status).to be 200
        expect(json_response[:profile][:name]).to eq(@normal_profile.name)
      end
      it "doesn't get other profile" do
        get :show, id: @manager_profile.id
        expect(response.status).to be 401
        expect(json_response[:error]).to eq("can't show profiles from other users")
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @manager_profile_attributes = FactoryGirl.attributes_for(:manager_profile, name: "Joe Williams")
      @normal_profile_attributes = FactoryGirl.attributes_for(:normal_profile, calories_limit: 3040)
    end
    context "with manager signed in" do
      before(:each) do
        sign_in @manager
      end
      it "edits own profile" do
        put :update, :id => @manager_profile.id, :profile=> @manager_profile_attributes
        expect(response.status).to be 200
        expect(json_response[:profile][:name]).to eq(@manager_profile_attributes[:name])
        @manager_profile.reload
        expect(@manager_profile.name).to eq(@manager_profile_attributes[:name])
      end
      it "edits other profiles" do
        put :update, :id => @normal_profile.id, :profile=> @normal_profile_attributes
        expect(response.status).to be 200
        expect(json_response[:profile][:calories_limit]).to eq(@normal_profile_attributes[:calories_limit])
        @normal_profile.reload
        expect(@normal_profile.calories_limit).to eq(@normal_profile_attributes[:calories_limit])
      end
      it "can change role to manager" do
        @normal_profile_attributes[:role] = "manager"
        put :update, :id => @normal_profile.id, :profile=> @normal_profile_attributes
        expect(response.status).to be 200
        expect(json_response[:profile][:role]).to eq(@normal_profile_attributes[:role])
        @normal_profile.reload
        expect(@normal_profile.role).to eq(@normal_profile_attributes[:role])
      end
      it "can't change role to admin" do
        @normal_profile_attributes[:role] = "admin"
        put :update, :id => @normal_profile.id, :profile=> @normal_profile_attributes
        expect(response.status).to be 401
        expect(json_response[:error]).to eq("can't change role to admin")
      end
    end
    context "with normal user signed in" do
      before(:each) do
        sign_in @user
      end
      it "edits own profile" do
        put :update, :id => @normal_profile.id, :profile=> @normal_profile_attributes
        expect(response.status).to be 200
        expect(json_response[:profile][:calories_limit]).to eq(@normal_profile_attributes[:calories_limit])
        @normal_profile.reload
        expect(@normal_profile.calories_limit).to eq(@normal_profile_attributes[:calories_limit])
      end
      it "doesn't edit other profile" do
        put :update, :id => @manager_profile.id, :profile=> @manager_profile_attributes
        expect(response.status).to be 401
        expect(json_response[:error]).to eq("can't update other profiles")
      end
      it "can't change role" do
        @normal_profile_attributes[:role] = "admin"
        put :update, :id => @normal_profile.id, :profile=> @normal_profile_attributes
        expect(response.status).to be 401
        expect(json_response[:error]).to eq("can't change role")
      end
    end
  end


  describe "DELETE #destroy" do
    context "with manager signed in" do
      before(:each) do
        sign_in @manager
      end
      it "destroys own profile" do
        delete :destroy, :id => @manager_profile.id
        expect(response.status).to be 204
        expect(Profile.where(id: @manager_profile.id).count).to eq(0)
        expect(Meal.where(user_id: @normal_profile.user.id).count).to eq(0)
      end
      it "destroys other profiles" do
        delete :destroy, :id => @normal_profile.id
        expect(response.status).to be 204
        expect(Profile.where(id: @normal_profile.id).count).to eq(0)
        expect(User.where(id: @normal_profile.user.id).count).to eq(0)
      end
    end
    context "with normal user signed in" do
      before(:each) do
        sign_in @user
      end
      it "destroys own profile" do
        delete :destroy, :id => @normal_profile.id
        expect(response.status).to be 204
        expect(Profile.where(id: @normal_profile.id).count).to eq(0)

      end
      it "can't destroy other profiles" do
        delete :destroy, :id => @manager_profile.id
        expect(response.status).to be 401
        expect(json_response[:error]).to eq("can't destroy other profiles")
        expect(Profile.where(id: @manager_profile.id).count).to eq(1)
      end
    end
  end
end
