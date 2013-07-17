class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid
  has_many :tasks

  def self.from_omniauth(auth) where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError
    logger.info e.to_s
    nil
  end

  def synch_facebook_messages(messages)
    messages.each do |message|
      task = self.tasks.build(
        :content => " #{message[:message]}", 
        :source => "Facebook message from #{message[:name]}." , 
        :user_id => self.id, 
        :action => "new", 
        :uid => "#{message[:id]}")
      puts message
      task.save unless Task.all.map(&:uid).include?(task.uid) 
    end
  end

  def info(info)
    facebook.get_connection("me", "#{info}")
  end

  def facebook_profile_picture
    facebook.get_picture(self.uid)
  end

  def favorite_television_shows
    info("television").collect { |show| show['name']}
  end

  def facebook_friends
    info("friends").collect { |friend| friend['name']}
  end

  def facebook_friend?(name)
    !(facebook_friends.grep(name).empty?)
  end

  def facebook_inbox
    info('inbox')
  end

  def facebook_new_messages?
    if 0 < info('inbox').collect { |thread| thread['unread'] }.inject{|sum,x| sum + x }
      return true
    else
      return false
    end
  end

  def facebook_new_messages
    new_messages = []
    threads = info('inbox').select { |thread| thread['unread'] > 0 }
    threads.collect do |thread| 
      puts thread['comments']['data'].last
      new_messages << { :name => thread['to']['data'].last['name'], :message => thread['comments']['data'].last['message'], :id => thread['comments']['data'].last['id'] }
    end
    new_messages
  end

  def facebook_last_message
    puts info('inbox').first
    info('inbox').first['from']
  end

end
