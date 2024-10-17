class UserMailer < ApplicationMailer
    default from: 'hiteshsukhpal03@gmail.com'

    def welcome_email(user)
      @content = "Welcome to My Awesome Site, #{@user}!"
      mail(to: 'harishgangani36@gmail.com', subject: @content)
    end
end
