class Task < ActiveRecord::Base
  attr_accessible :source, :content, :action, :user_id, :uid

  def self.update_facebook_content(user)
    messages = user.facebook_new_messages? ? user.facebook_new_messages : nil
    if messages
      messages.each do |message| 
        task = user.tasks.build(:content => "Facebook message from #{message[:name]}. #{message[:message]}", :source => "Facebook", :user_id => user.id, :action => "new", :uid => "#{message[:id]}")
	puts message
        task.save unless Task.all.map(&:uid).include?(task.uid) 
      end
    end
  end

  def self.mark_as_viewed
    action = 'viewed' if action == 'new'
    save
  end

end

