class Contact < MailForm: :Base

  @contact = attribute :name, validate: true
  @contact = attribute :email, validate: /\A[^@\s]+@[^@\s]+\z/i
  @contact = attribute :message

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: "My Contact Form",
      to: "wilkerwk@gmail.com",
      from: %("#{:name}" <#{:email}>)
    }
  end
end
