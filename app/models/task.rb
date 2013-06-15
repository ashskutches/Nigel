class Task < ActiveRecord::Base
  attr_accessible :source, :content, :action, :user_id, :uid

  def self.update_facebook_content(users)
    users.each do |user|
      messages = user.facebook_new_messages? ? user.facebook_new_messages : nil
      Task.build_from_facebook_messages(user, messages)
    end
  end

  def self.build_from_facebook_messages(user, messages)
    messages.each do |message|
      task = user.tasks.build(
        :content => " message from #{message[:name]}. #{message[:message]}", 
        :source => "Facebook", 
        :user_id => user.id, 
        :action => "new", 
        :uid => "#{message[:id]}")
      puts message
      task.save unless Task.all.map(&:uid).include?(task.uid) 
    end
  end

  def mark_as_viewed
    action = 'viewed' if action == 'new'
    save
  end
  
end

