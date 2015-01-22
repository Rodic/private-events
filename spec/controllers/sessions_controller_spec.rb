require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "new" do

    it "renders correct template" do
      expect(get :new).to render_template(:new)
    end
  end

  describe "create" do
    it "search db for user by email" do
      user = FactoryGirl.create(:user)
      atts = FactoryGirl.attributes_for(:user)
      expect(User).to receive(:find_by_email).with(atts[:email]).and_return(user)
      post :create, user: atts
    end

    context "successfull signin" do

      it "sets user id into session hash" do
        user = FactoryGirl.create(:user)
        atts = FactoryGirl.attributes_for(:user)
        post :create, user: atts
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to user page" do
        user = FactoryGirl.create(:user)
        atts = FactoryGirl.attributes_for(:user)
        expect(post :create, user: atts).to redirect_to(user)
      end
    end

    context "unsuccessfull signin" do
      it "renders 'new' template" do
        expect(post :create, user: {}).to render_template(:new)
      end
    end
  end

  describe "destroy" do
  end
end
