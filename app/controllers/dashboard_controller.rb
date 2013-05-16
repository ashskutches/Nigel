class DashboardController < ApplicationController

  def homepage
    if current_user  
     Nigal.gather_knowledge(current_user)
    end
    current_user ? @tasks = current_user.tasks.all : nil
    @tasks.each { |task| Nigal.speak(task.content) }
    Task.destroy_all
  end

end
