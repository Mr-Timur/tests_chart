class ChartsController < ApplicationController
  def index
    # Can be problem of performance if database will contain a big count of sessions
    @sessions = Session.all
  end
end