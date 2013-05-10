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
    unless message.nil? || message == 0
      body = message.parts[0].body.decoded
    end
    puts "==============" 
    puts "Email.parts[0].body.decoded: #{body}" 
    puts "==============" 
    puts "Email.text_part: #{message.text_part}" 
    puts "==============" 
    Nigal.talk(body)
  end
end
