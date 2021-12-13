# rails-docker-twilio
# README
This application is to demonstrate an integration between Rails and Twilio
Put the random ngrok number in the Twilio phone number settings under A MESSAGE COMES IN Webhook
https://console.twilio.com/us1/develop/phone-numbers/manage/active?frameUrl=%2Fconsole%2Fphone-numbers%2Fincoming%3Fx-target-region%3Dus1

Because I have a Twilio test account I can only send texts to my personal number.1

ENV variables required
- TWILIO_ACCOUNT_SID
- TWILIO_AUTH_TOKEN
- TWILIO_MESSAGING_SERVICE_SID

You will need docker and ngrok installed.

Start ngrok in a terminal window. This will allow us to expose our docker container to the WWW
    ngrok http 3001      

To run
    docker-compose up

To enter the console
    docker-compose run --rm --service-ports app bash
