class Task < ActiveRecord::Base
  attr_accessible :source, :content, :action, :user_id, :uid

  def self.update_facebook_content(users)
    users.each do |user|
      messages = user.facebook_new_messages? ? user.facebook_new_messages : nil
      user.synch_facebook_messages(messages) if messages
    end
  end

  def self.update_all_facebook_content
    puts "==== Begin updating all facebook content ===="
    Task.update_facebook_content(User.all)
    puts "==== Facebook content update complete ===="
  end

  def self.mark_as_viewed(tasks)
    tasks.each do |task| 
      task.action = 'viewed' if task.action == 'new'
      task.save
    end
  end
  
end

