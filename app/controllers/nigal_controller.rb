class NigalController < ApplicationController

  def listen
    content = params[:content]

    render json: { status: 'ok', content: content }
  end
end
