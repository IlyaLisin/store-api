# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include ApplicationHelpers
  helper ApplicationHelpers

  default from: 'from@example.com'
  layout 'mailer'
end
