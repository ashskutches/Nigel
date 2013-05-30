class Nigal < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.speak(content)
    system "espeak '#{content}'"
  end


end
