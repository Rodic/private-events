class UsersMailer < ActionMailer::Base

  def thank_you(user)
    @user = user
    mail to: @user.email, subject: "Thank you"
  end
end
