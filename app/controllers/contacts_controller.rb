class ContactsController < ApplicationController
  skip_before_action :require_login

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver_now
      flash[:success] = 'メールを送信しました'
      redirect_to new_contact_path
    else
      flash[:danger] = 'メールを送信出きませんでした'
      redirect_to new_contact_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :message)
  end
end
