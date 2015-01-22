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
  end
end
