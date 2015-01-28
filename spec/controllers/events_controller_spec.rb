require 'rails_helper'

RSpec.describe EventsController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }
  
  describe "index" do
    it "renders correct template" do
      expect(get :index).to render_template(:index)
    end

    it "provides all events to template" do
      get :index
      expect(assigns(:past_events)).to be_kind_of(ActiveRecord::Relation)
      expect(assigns(:upcoming_events)).to be_kind_of(ActiveRecord::Relation)
    end
  end

  describe "new" do

    before do
      session[:user_id] = user.id
    end

    it "renders correct template" do
      expect(get :new, user_id: user.id).to render_template(:new)
    end
    
    it "provides empty event to view" do
      get :new, user_id: user.id
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "create" do

    before do
      session[:user_id] = user.id
    end
    
    context "valid event params" do

      let(:atts) { FactoryGirl.attributes_for(:event) }

      it "creates event through user" do
        expect{post :create, user_id: user.id, event: atts}.to change(Event, :count).by(1)
      end

      it "redirects to user page" do
        expect(post :create, user_id: user.id, event: atts).to redirect_to(user_path(user))
      end
    end

    context "invalid event params" do

      let(:atts) { FactoryGirl.attributes_for(:event, title: "") }

      it "doesn't create new event" do
        expect{post :create, user_id: user.id, event: atts}.to_not change(Event, :count)
      end

      it "redirects to new event page" do
        expect(post :create, user_id: user.id, event: atts).to redirect_to(new_user_event_path(user))
      end
    end
  end

  describe "show" do

    let(:event) { user.events.create(FactoryGirl.attributes_for(:event)) }

    it "renders correct template" do
      expect(get :show, id: event.id).to render_template(:show)
    end

    it "provides event to template" do
      get :show, id: event.id
      expect(assigns(:event)).to eq(event)
    end
  end
end
