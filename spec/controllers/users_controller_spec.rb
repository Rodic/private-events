require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "new" do

    it "renders right template" do
      expect(get :new).to render_template(:new)
    end

    it "provides new instance of user to view" do
      u = double("user")
      allow(User).to receive(:new).and_return(u)

      get :new
      expect(assigns(:user)).to eq(u)
    end
  end

  describe "create" do

    context "valid attributes" do

      it "creates user in database" do
        expect{ 
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to user page" do
        expect( 
          post :create, user: FactoryGirl.attributes_for(:user)
        ).to redirect_to(User.last)
      end
    end

    context "invalid attributes" do

      it "doesn't create a user in database" do
        expect{ 
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "renders 'new' template" do
        expect( 
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        ).to render_template(:new)
      end
    end
  end
end
