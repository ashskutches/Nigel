class Nigal < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.speak(content)
    system "espeak '#{content}'"
  end

  def self.gather_knowledge(user)
    if user.facebook_new_messages? 
      messages = user.facebook_new_messages
      messages.each do |message| 
        task = user.tasks.build(:content => "Facebook message from #{message[:name]}. #{message[:message]}", :source => "Facebook", :user_id => user.id, :action => "delete")
        task.save
      end
    end
  end
end
