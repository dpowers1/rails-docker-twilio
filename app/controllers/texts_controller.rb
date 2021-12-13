class TextsController < ApplicationController
  before_action :set_text, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /texts/1 or /texts/1.json
  def show
  end

  # GET /texts/new
  def new
    @text = Text.new
  end

  # POST /texts or /texts.json
  def create
    @user = User.find(params[:user_id])
    @text = @user.texts.create(text_params)

    send_text(@user.country_code, @user.phone_number, @text.outbound)
    redirect_to user_path(@user)
  end

  def reply
    message_body = params["Body"]
    from_number = params["From"]

    # We are assuming its replying from a US number at this point
    # In the future we could put a check based on params["FromCountry"]
    from_number = from_number[2..-1]

    # Honestly we should have a check for duplicate phone numbers
    # when we create users
    @user = User.where(phone_number: from_number).first

    text_hash = {
      outbound: nil,
      inbound: message_body,
      user_id: @user.id
    }

    @text = @user.texts.create(text_hash)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def text_params
      params.require(:text).permit(:outbound, :inbound, :user_id)
    end

    def send_text(country_code, phone_number, text_message)
      account_sid = ENV["TWILIO_ACCOUNT_SID"]
      auth_token = ENV["TWILIO_AUTH_TOKEN"]
      @client = Twilio::REST::Client.new(account_sid, auth_token) 
      
      combined_number = "+#{country_code}#{phone_number}"

      message = @client.messages.create( 
                                   body: text_message,  
                                   messaging_service_sid: ENV["TWILIO_MESSAGING_SERVICE_SID"],      
                                   to: combined_number
                                 ) 
    end
end
