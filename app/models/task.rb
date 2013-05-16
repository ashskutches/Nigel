class Task < ActiveRecord::Base
  attr_accessible :source, :content, :action, :user_id

  def self.gather_tasks
  end

end
