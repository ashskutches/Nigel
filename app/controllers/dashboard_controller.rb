class DashboardController < ApplicationController

  def homepage
    @feed = []
    @feed << {source: "Tasks", content: Task.last.title}

    if current_user
      @feed << { source: "Facebook", content: current_user.info('feed').first['message']}
      @feed << { source: "Gmail", content: "Nothing" }
    end

    @feed
    
  end

end
