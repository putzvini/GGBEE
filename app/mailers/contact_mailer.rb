class ContactsMailer < ActionMailer::Base
  default from: "beeggbee@gmail.com"

  def confirmation
    @contact = contact_params
    mail( :to => "beeggbee@gmail.com", :subject => "You Have a Message From Your Website")
  end
end
