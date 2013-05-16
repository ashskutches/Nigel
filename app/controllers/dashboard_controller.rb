class DashboardController < ApplicationController

  def homepage
    @feed = []
    @feed << {source: "Tasks", content: Task.last.title}

    if current_user
      @feed << { source: "Facebook", content: current_user.facebook_new_messages }
      @feed << { source: "Gmail", content: "Nothing" }
    end

    Nigal.talk(current_user.facebook_new_messages)
    @feed
    
  end

end
