class UserMailer < ApplicationMailer
    default from: 'Management System'

    def welcome_email(user)
      mail(to: user[:email],
         body: "Hello, <br><br>
                Thank you for joining <b>Management System</b> We're thrilled to have you onboard.<br>
                As a member, you'll gain access to exclusive features and resources to help you make the most of our platform. To get started, simply log in and explore all we have to offer.
                If you have any questions or need assistance, feel free to reach out at any time. We're here to help!
                Welcome once again, and we look forward to supporting you on this journey.<br><br>
                Warm regards,<br><br>
                <b>Hitesh Sukhpal</b><br>
                <b>Full Stack Developer</b>",
         content_type: "text/html",
         subject: "Welcome to Management System - You're Successfully Registered!"
         )
    end
end
