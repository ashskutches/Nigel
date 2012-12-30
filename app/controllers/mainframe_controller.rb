class MainframeController < ApplicationController

  def homepage
    @feed = []

    @feed << {source: "Tasks", content: Task.last.title}

    if current_user
      @feed << { source: "Facebook", content: current_user.info('feed').first['message']}
      @feed << { source: "Gmail", content: current_user.gmail_inbox.first }
    end
    @feed
  end

end
