class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid
  require 'pp'

  def self.from_omniauth(auth)
    puts "====Authentication=Token===="
    pp auth
    puts "============================"
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      user.talk("Your favorite movie is #{user.favorite_television_shows}")

    end
  end

  def talk(content)
    system "espeak 'Your favorite television shows are #{content}'"
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError
    logger.info e.to_s
    nil
  end

  def favorite_television_shows
    facebook.get_connection("me", "television").collect { |show| show['name']}
  end

  def facebook_friends
    facebook.get_connection("me", "friends").collect { |friend| friend['name']}
  end

  def is_facebook_friend?(name)
    !(facebook_friends.grep(name).empty?)
  end

end
