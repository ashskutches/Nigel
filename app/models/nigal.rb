class Nigal < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.talk(content)
    system "espeak '#{content}'"
  end


end
