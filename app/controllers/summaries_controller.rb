class SummariesController < ApplicationController
  def index
  end

  def summary
    @partial = params[:partial]
  end

  def scratch
  end
end
