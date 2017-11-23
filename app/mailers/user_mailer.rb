class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailers.subject")
  end

  def password_reset
    @greeting = t("mailers.greeting")
    mail to: "to@example.org"
  end
end
