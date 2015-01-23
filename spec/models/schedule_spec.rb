require 'rails_helper'

RSpec.describe Schedule, :type => :model do
  
  describe "validations" do
    it "must have user" do
      expect(FactoryGirl.build(:schedule, user_id: nil).valid?).to be_falsey
    end

    it "must have event" do
      expect(FactoryGirl.build(:schedule, event_id: nil).valid?).to be_falsey
    end
  end
end
