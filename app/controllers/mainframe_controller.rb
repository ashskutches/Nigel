class MainframeController < ApplicationController

  def homepage
    @feed = []
    @feed << {source: "Tasks", content: Task.last.title}
    if current_user
      @feed << { source: "Facebook", content: current_user.info('feed').first['message']}
    end
    @feed
  end

end
