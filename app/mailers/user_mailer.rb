class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailers.subject_acc")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailers.subject_pass")
  end
end
