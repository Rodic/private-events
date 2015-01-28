require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "validations" do

    context "valid users" do
      let(:user) { FactoryGirl.build(:user) }

      it "validates users with valid email addresses" do
        expect(user.valid?).to be_truthy
      end
    end

    context "invalid users" do

      it "fails to validate users with invalid email format" do
        expect(FactoryGirl.build(:user, email: "invalid@email").valid?).to be_falsey
      end

      it "fails to validate users when email is too long" do
        expect(FactoryGirl.build(:user, email: "use#{'r'*30}@private-events.com").valid?).to be_falsey
      end

      it "fails to validate user with short password" do
        u = FactoryGirl.build(:user, password: "123456", password_confirmation: "123456")
        expect(u.valid?).to be_falsey
      end
    end
  end

  describe "attribute normalization" do
    it "convert user email to lowercase" do
      u = FactoryGirl.create(:user, email: "UsEr@Private-EVENTS.com")
      expect(u.email).to eq(u.email.downcase)
    end
  end
  
  describe "associations" do   

    it "allows ceration of events" do
      user  = FactoryGirl.create(:user)
      event = user.events.build(title: "test", location: "t", date: 1.week.from_now)
      expect(event.creator_id).to eq(user.id)
    end

    it "can add attendees to its events" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user, email: "second_user@private-events.com")
      user1.events.create(FactoryGirl.attributes_for(:event))
      user1.events.last.attendees << user2
      expect(user1.events.last.attendees.last).to eq(user2)
    end

    it "has many invites" do
      user  = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event)
      invitation = event.invitations.create(event_id: event.id, recipient_id: user.id)
      
      expect(user.invitations).to eq([invitation])
    end
  end

  describe "scopes" do
    
    it "can query db for past events" do
      user = FactoryGirl.create(:user)
      event1 = FactoryGirl.create(:event)
      event2 = FactoryGirl.create(:event, title: "Another event")
      event3 = FactoryGirl.create(:event, date: 1.week.ago)
      events = [ event1, event2, event3 ]
      user.attended_events << events

      expect(user.attended_events).to eq(events)

      expect(user.upcoming_events).to eq([event1, event2])
      expect(user.previous_events).to eq([event3])
    end
  end
end
