class ContactsController < ApplicationController
  def index
    @contact = Contact.new(params[:name])
      @contact.request = request
      if @contact.deliver
        flash.now[:notice] = 'Thank you for your message!'
      else
        render :new
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end

  private
    def payment_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
