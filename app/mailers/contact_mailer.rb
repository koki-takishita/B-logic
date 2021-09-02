class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: 'tkkokitk@gmail.com', subject: 'お問い合わせ内容'
  end
end
