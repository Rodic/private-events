require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  
  describe "validations" do
    it "must have event_id" do
      expect(FactoryGirl.build(:invitation, event_id: nil).valid?).to be_falsey
    end

    it "must have recipient_id" do
      expect(FactoryGirl.build(:invitation, recipient_id: nil).valid?).to be_falsey
    end
  end

  describe "associations" do
    
    it "belongs to event" do
      e = FactoryGirl.create(:event)
      expect(e).to respond_to(:invitations)

      i = e.invitations.create(FactoryGirl.attributes_for(:invitation))
      expect(i.event).to eq(e)
    end

    it "has sender through event" do
      u = FactoryGirl.create(:user)
      e = u.events.create(FactoryGirl.attributes_for(:event))
      i = e.invitations.create(FactoryGirl.attributes_for(:invitation))

      expect(i).to respond_to(:sender)
      expect(i.sender).to eq(u)
    end

    it "belongs to recepient" do
      u = FactoryGirl.create(:user)
      e = FactoryGirl.create(:event)
      i = e.invitations.create(event_id: e.id, recipient_id: u.id)

      expect(i.recipient).to eq(u)
    end
  end
end
