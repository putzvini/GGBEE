class ContactController < ApplicationController
  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      mail = RestaurantMailer.with(restaurant: @contact).create_confirmation
      mail.deliver_now
      redirect_to contact_path(@contact)
    else
      render :new
    end
  end
end
