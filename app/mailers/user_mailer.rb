class UserMailer < ApplicationMailer
    default from: 'hiteshsukhpal03@gmail.com'

    def welcome_email(user)
      mail(to: user[:email],
         body: "Thanks for signup in my project",
         content_type: "text/html",
         subject: "Successfully signed up"
         )
    end
end
