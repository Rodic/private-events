require 'rails_helper'

RSpec.describe Event, :type => :model do
  
  describe "validations" do
    
    it "validates event with proper data" do
      expect(FactoryGirl.build(:event).valid?).to be_truthy
    end

    it "validates event without description" do
      expect(FactoryGirl.build(:event, description: "").valid?).to be_truthy
    end

    it "fails to validate event without title" do
      expect(FactoryGirl.build(:event, title: "").valid?).to be_falsey
    end

    it "fails to validate event without date" do
      expect(FactoryGirl.build(:event, date: nil).valid?).to be_falsey
    end

    it "fails to validate event without location" do
      expect(FactoryGirl.build(:event, location: "").valid?).to be_falsey
    end

    it "fails to validate event when title is too long" do
      expect(FactoryGirl.build(:event, title: "a"*141).valid?).to be_falsey
    end

    it "fails to validate event when date is in the past" do
      expect(FactoryGirl.build(:event, date: 1.week.ago).valid?).to be_falsey
    end

    it "fails to validate event when description is too long" do
      expect(FactoryGirl.build(:event, description: "a"*801).valid?).to be_falsey
    end
  end

  describe "associations" do

    it "allows to find creator" do
      user  = FactoryGirl.create(:user)
      event = user.events.build(title: "test", location: "t", date: 1.week.from_now)
      expect(event.creator).to eq(user)
    end
  end
end
