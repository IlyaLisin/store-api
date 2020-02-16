class ApplicationMailer < ActionMailer::Base
  include ApplicationHelpers
  add_template_helper ApplicationHelpers

  default from: 'from@example.com'
  layout 'mailer'
end
