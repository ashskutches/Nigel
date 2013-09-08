class Nigal < ActiveRecord::Base
  # attr_accessible :title, :body

  def initialize
    @cleverbot ||= Cleverbot::Client.new
  end

  def talk text
    text ||= "I don't feel like talking right now"
    text.gsub /(Nigel+|nigel+)/, ""
    @cleverbot.write text
  end

end
