#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "mailman"

Mailman.config.pop3 = {
  server: 'pop.gmail.com', port: 995, ssl: true,
  username: 'appnigel@gmail.com',
  password: 'rapturx1' 
}

Mailman::Application.run do
  default do
    body = message.parts[0].body.decoded
    puts "==============" 
    puts "Email.parts[0].body.decoded: #{body}" 
    puts "==============" 
    puts "Email.text_part: #{message.text_part}" 
    puts "==============" 
    User.talk(body)
  end
end
