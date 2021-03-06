require './config/boot'
require './config/environment'
require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(1.minutes, "Update Facebook content") do
  Task.update_all_facebook_content
end
