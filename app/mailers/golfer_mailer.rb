class GolferMailer < ApplicationMailer

  def account_activation(golfer)
    @golfer = golfer
    mail to: golfer.email, subject: "Account Activation"
  end

  def password_reset(golfer)
  	@golfer = golfer
    mail to: golfer.email, subject: "Password Reset"
  end
end
