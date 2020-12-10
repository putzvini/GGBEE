module Mailers
  class ApplicationMailer < ActionMailer::Base
    default from: 'beeggbee@gmail.com'
    layout 'mailer'
  end
end
