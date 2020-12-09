class ContactMailer < ApplicationMailer
  def create_confirmation
    @contact = params[:contact]

    mail(
      to:       @contact.user.email,
      subject:  "Contact #{@contact.name} created!"
    )
  end
end
