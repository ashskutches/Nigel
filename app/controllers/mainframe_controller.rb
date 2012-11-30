class MainframeController < ApplicationController

  def homepage
    @tasks = Task.all
  end

end
