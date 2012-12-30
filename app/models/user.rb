class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

  def self.connect_to_gmail
    require 'gmail'
    Gmail.connect('appnigel@gmail.com', 'rapturx1')
  end

  def self.from_omniauth(auth) where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def gmail
    @gmail ||= User.connect_to_gmail
  end

  def gmail_inbox
    mail = gmail.inbox.find(:unread)
    if mail
      all_mail = mail.collect do |m|
        m.message.html_part.body
      end
    else
      all_mail = []
    end
    all_mail
  end

  def talk(content)
    system "espeak '#{content}'"
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError
    logger.info e.to_s
    nil
  end

  def info(info)
    facebook.get_connection("me", "#{info}")
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

end
