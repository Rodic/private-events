require 'rails_helper'

RSpec.describe InvitesController, :type => :controller do

  describe "#create" do

    let(:event) { FactoryGirl.create(:event) }
    let(:user)  { FactoryGirl.create(:user)  }

    it "redirects to event page" do
      expect(post :create, event_id: event.id, email: user.email).to redirect_to(event_path(event))
    end

    it "creates new invitation" do
      expect{post :create, event_id: event.id, email: user.email}.to change(Invitation, :count).by(1)
    end
  end

  describe "#accept" do

    let(:event)  { FactoryGirl.create(:event) }
    let(:user)   { FactoryGirl.create(:user)  }
    let(:invite) { Invitation.create(event_id: event.id, recipient_id: user.id) }

    it "redirects to user page" do
      expect(get :accept, id: invite.id).to redirect_to(user_path(user))
    end

    it "adds recipient to attendees" do
      get :accept, id: invite.id
      expect(event.attendees).to include(user)
    end

    it "deletes invitation from db" do
      get :accept, id: invite.id
      expect{Invitation.find(invite.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#decline" do

    let(:event)  { FactoryGirl.create(:event) }
    let(:user)   { FactoryGirl.create(:user)  }
    let(:invite) { Invitation.create(event_id: event.id, recipient_id: user.id) }

    it "redirects to user page" do
      expect(get :decline, id: invite.id).to redirect_to(user_path(user))
    end

    it "does not add recipient to attendees" do
      get :decline, id: invite.id
      expect(event.attendees).to_not include(user)
    end

    it "deletes invitation from db" do
      get :decline, id: invite.id
      expect{Invitation.find(invite.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
