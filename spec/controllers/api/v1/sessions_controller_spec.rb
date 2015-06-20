require "spec_helper"

describe Api::V1::SessionsController do
  describe "Session" do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
      @credentials = {:email => 'asd@def.com', :password => 'password', :authentication_token => 'asd'}
      @user = FactoryGirl.create(:user, @credentials)
    end

    describe "sign in" do
      it "should sign in successfully and return authentication token" do
        post :create, {'user' => @credentials}, :format => :json
        expect(response.code).to eq("200")
        expect(controller.current_user).not_to be_nil
        expect(controller).to be_signed_in
        expect(response.body['token']).not_to be_nil
      end

      it "should return authentication failure message" do
        post :create, {'user' => {:email => 'asd@sad.com', :password => 'asd'}}, :format => :json
        expect(response.code).to eq("401")
        expect(controller.current_user).to be_nil
        expect(controller).not_to be_signed_in
      end
    end

    describe "Sign Out" do
      it "should signout the user successfully" do
        sign_in @user
        delete :destroy, {:auth_token => @user.authentication_token}, :format => :json
        expect(controller.current_user).to be_nil
        expect(controller).not_to be_signed_in
        expect(response.code).to eq("200")
      end

      it "should return error message if the toekn is not passed" do
        sign_in @user
        delete :destroy, :format => :json
        expect(response.code).to eq("401")
        expect(response.body['errors']).not_to be_nil
      end
    end

  end
end
