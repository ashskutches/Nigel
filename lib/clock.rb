require 'clockwork'
include Clockwork
require './config/boot'
    require './config/environment'

handler do |job|
  puts "Running #{job}"
end

puts Task.first.content
every(1.minutes, Task.update_all_facebook_content)
