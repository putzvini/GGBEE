class ContactsMailer < ActionMailer::Base2
  default from: "beeggbee@gmail.com"

  def confirmation
    @contact = contact_params
    mail( :to => "beeggbee@beeggbee.com", :subject => "You Have a Message From Your Website")
  end
end
