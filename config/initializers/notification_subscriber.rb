#!/usr/bin/env ruby
logger = Logger.new('./log/exceptions.log')
logger.formatter = Logger::Formatter.new

ActiveSupport::Notifications.subscribe 'exception.interactors' do |event|
  logger.error "Error with interactor: #{event.payload[:interactor]}"
  logger.error "Exception: #{event.payload[:exception]}"
  logger.error "Backtrace: #{event.payload[:backtrace].join("\n")}"
end
