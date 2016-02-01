# Preview all emails at http://localhost:3000/rails/mailers/golfer_mailer
class GolferMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/golfer_mailer/account_activation
  def account_activation
    GolferMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/golfer_mailer/password_reset
  def password_reset
    GolferMailer.password_reset
  end

end
