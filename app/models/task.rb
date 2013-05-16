class Task < ActiveRecord::Base
  attr_accessible :source, :content, :action
end
