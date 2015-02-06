require "rails_helper"

RSpec.describe UsersMailer, :type => :mailer do
  describe "thank_you" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UsersMailer.thank_you(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Thank you")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@private-events.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/Thank you for choosing us/)
    end
  end
end
