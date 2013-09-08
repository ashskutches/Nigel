class NigalController < ApplicationController
  before_filter :start_up_cleverbot


  def talk
    content = params[:content]

    render json: { status: 'ok', text: @nigal.talk(content) }
  end


  private

  def start_up_cleverbot
    @nigal ||= Nigal.new
  end

end
